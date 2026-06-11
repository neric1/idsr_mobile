import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/ebola/ebola_bloc.dart';
import 'package:idsr/application/ebola/ebola_state.dart';
import 'package:idsr/data/idsr/models/threshold_model.dart';

const _dxSuspectedCases = 'kdSei0GD1mM';
const _dxConfirmedCases = 'OoZOXclQI7l';
const _dxSuspectedDeaths = 'A8p2Spxdtg1';
const _dxConfirmedDeaths = 'E9dLxqaEL3g';

String _formatPeriodDate(String period) {
  if (period.length == 8) {
    return '${period.substring(6, 8)}/${period.substring(4, 6)}/${period.substring(0, 4)}';
  }
  return period;
}

String _countryAbbr(String full) {
  const map = {
    'democratic republic of the congo': 'DRC',
    'uganda': 'Uganda',
  };
  return map[full.toLowerCase()] ??
      full.split(' ').map((w) => w.isNotEmpty ? w[0] : '').join();
}

List<ProvinceData> buildOutbreakData(ThresholdModel dataResponse) {
  if (dataResponse == null) return const [];

  final dynamic rawRows =
  dataResponse is Map ? dataResponse.rows : dataResponse.rows;
  if (rawRows is! List) return const [];

  final dynamic rawMeta = dataResponse.metaData;
  if (rawMeta == null) return const [];

  final meta = rawMeta is Map<String, dynamic>
      ? rawMeta
      : (rawMeta as Map).cast<String, dynamic>();

  final items = (meta['items'] as Map?)?.cast<String, dynamic>() ?? {};
  final ouHierarchy =
      (meta['ouNameHierarchy'] as Map?)
          ?.map((k, v) => MapEntry(k.toString(), v.toString())) ??
          {};

  final Map<String, ({String pe, double value})> latestByOuDx = {};
  final Map<String, String> latestPeriodByOu = {};

  for (final row in rawRows) {
    if (row is! List || row.length < 4) continue;

    final dx = row[0].toString();
    final pe = row[1].toString();
    final ou = row[2].toString();
    final value = double.tryParse(row[3].toString()) ?? 0;

    if (dx != _dxSuspectedCases &&
        dx != _dxConfirmedCases &&
        dx != _dxSuspectedDeaths &&
        dx != _dxConfirmedDeaths) {
      continue;
    }

    final key = '$ou:$dx';
    final current = latestByOuDx[key];
    if (current == null || pe.compareTo(current.pe) > 0) {
      latestByOuDx[key] = (pe: pe, value: value);
    }

    final currentOuPeriod = latestPeriodByOu[ou];
    if (currentOuPeriod == null || pe.compareTo(currentOuPeriod) > 0) {
      latestPeriodByOu[ou] = pe;
    }
  }

  double getValue(String ouId, String dxId) => latestByOuDx['$ouId:$dxId']?.value ?? 0;

  final ouIds = latestByOuDx.keys.map((k) => k.split(':')[0]).toSet();
  final byProvince = <String, List<ZoneData>>{};
  final countryByProvince = <String, String>{};

  List<String> parseHierarchyFromOuValue(String ouValue) {
    if (!ouValue.contains('/')) {
      return const [];
    }
    return ouValue.split('/').where((p) => p.isNotEmpty).toList();
  }

  for (final ouId in ouIds) {
    final partsFromOuValue = parseHierarchyFromOuValue(ouId);
    final parts = partsFromOuValue.isNotEmpty
        ? partsFromOuValue
        : (ouHierarchy[ouId]?.split('/').where((p) => p.isNotEmpty).toList() ?? const []);

    // final country = parts.isNotEmpty ? _countryAbbr(parts.first) : 'Unknown';
    final country = parts.isNotEmpty && parts.length>1? _countryAbbr(parts[1]) : 'Unknown';
    final province = parts.length >= 2 ? parts[parts.length - 2] : 'Unknown';
    final zoneName = (items[ouId] as Map?)?['name']?.toString() ??
        (parts.isNotEmpty ? parts.last : ouId);

    final suspected = getValue(ouId, _dxSuspectedCases).round();
    final confirmed = getValue(ouId, _dxConfirmedCases).round();
    final suspectedDeaths = getValue(ouId, _dxSuspectedDeaths).round();
    final confirmedDeaths = getValue(ouId, _dxConfirmedDeaths).round();
    final cfr =
    confirmed == 0 ? '0' : ((confirmedDeaths / confirmed) * 100).toStringAsFixed(1);
    final latestDate = _formatPeriodDate(latestPeriodByOu[ouId] ?? '');

    byProvince.putIfAbsent(province, () => []).add(
      ZoneData(
        name: zoneName,
        latestDate: latestDate,
        suspected: suspected,
        confirmed: confirmed,
        suspectedDeaths: suspectedDeaths,
        confirmedDeaths: confirmedDeaths,
        cfr: cfr,
      ),
    );
    countryByProvince[province] = country;
  }

  return byProvince.entries
      .map(
        (entry) => ProvinceData(
      name: entry.key,
      country: countryByProvince[entry.key] ?? 'Unknown',
      zones: entry.value..sort((a, b) => a.name.compareTo(b.name)),
    ),
  )
      .toList()
    ..sort((a, b) => a.name.compareTo(b.name));
}

class OutbreakOverviewPage extends StatelessWidget {
  const OutbreakOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EbolaBloc, EbolaState>(
      builder: (context, state) {
        if (state is EbolaLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is EbolaError) {
          return Center(child: Text(state.message));
        }

        if (state is EbolaLoaded) {
          final provinces = buildOutbreakData(state.data);
          if (provinces.isEmpty) {
            return const SizedBox.shrink();
          }

          var totalSuspected = 0;
          var totalConfirmed = 0;
          var totalSuspectedDeaths = 0;
          var totalConfirmedDeaths = 0;

          for (final province in provinces) {
            for (final zone in province.zones) {
              totalSuspected += zone.suspected;
              totalConfirmed += zone.confirmed;
              totalSuspectedDeaths += zone.suspectedDeaths;
              totalConfirmedDeaths += zone.confirmedDeaths;
            }
          }

          final totalCfr = totalConfirmed == 0
              ? '0'
              : ((totalConfirmedDeaths / totalConfirmed) * 100).toStringAsFixed(1);

          return Column(
            children: [
              const OverviewHeaderCard(),
              const SizedBox(height: 16),
              ...provinces.map((province) => ProvinceSection(province: province)),
              const SizedBox(height: 30),
              // TotalSummaryCard(
              //   suspected: totalSuspected,
              //   confirmed: totalConfirmed,
              //   suspectedDeaths: totalSuspectedDeaths,
              //   confirmedDeaths: totalConfirmedDeaths,
              //   cfr: totalCfr,
              // ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class OverviewHeaderCard extends StatelessWidget {
  const OverviewHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFBFD8FB), Color(0xFF5B99EF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Outbreak Overview by Province and Health Zone',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class ProvinceSection extends StatelessWidget {
  final ProvinceData province;

  const ProvinceSection({super.key, required this.province});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF2C469A),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${province.name}, ${province.country}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ...province.zones.map((zone) => ZoneCard(zone: zone)),
        ],
      ),
    );
  }
}

class ZoneCard extends StatelessWidget {
  final ZoneData zone;

  const ZoneCard({super.key, required this.zone});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF2FB),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: const Color(0xFFD7E2F2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text(
            '${zone.name} (${zone.latestDate})',
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: Color(0xFF1B2430),
            ),
          ),
          const SizedBox(height: 8),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
            children: [
              // StatTile(label: 'Suspected cases', value: '${zone.suspected}'),
              StatTile(label: 'Confirmed cases', value: '${zone.confirmed}'),
              // StatTile(label: 'Suspected deaths', value: '${zone.suspectedDeaths}'),
              StatTile(label: 'Confirmed deaths', value: '${zone.confirmedDeaths}'),
              StatTile(label: 'CFR %', value: zone.cfr),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class StatTile extends StatelessWidget {
  final String label;
  final String value;

  const StatTile({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1E2A3A),
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              height: 1.2,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6A7483),
            ),
          ),
        ],
      ),
    );
  }
}

// class TotalSummaryCard extends StatelessWidget {
//   final int suspected;
//   final int confirmed;
//   final int suspectedDeaths;
//   final int confirmedDeaths;
//   final String cfr;
//
//   const TotalSummaryCard({
//     super.key,
//     required this.suspected,
//     required this.confirmed,
//     required this.suspectedDeaths,
//     required this.confirmedDeaths,
//     required this.cfr,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
//       decoration: BoxDecoration(
//         color: const Color(0xFF2C469A),
//         borderRadius: BorderRadius.circular(7),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Total',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//           const SizedBox(height: 7),
//           GridView.count(
//             crossAxisCount: 5,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             crossAxisSpacing: 5,
//             mainAxisSpacing: 5,
//             childAspectRatio: 1.0,
//             children: [
//               TotalTile(label: 'Suspected cases', value: '$suspected'),
//               TotalTile(label: 'Confirmed cases', value: '$confirmed'),
//               TotalTile(label: 'Suspected deaths', value: '$suspectedDeaths'),
//               TotalTile(label: 'Confirmed deaths', value: '$confirmedDeaths'),
//               TotalTile(label: 'CFR %', value: cfr),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TotalTile extends StatelessWidget {
//   final String label;
//   final String value;
//
//   const TotalTile({
//     super.key,
//     required this.label,
//     required this.value,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(.12),
//         borderRadius: BorderRadius.circular(7),
//       ),
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             value,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//           const SizedBox(height: 3),
//           Text(
//             label,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               color: Colors.white70,
//               fontSize: 10,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ProvinceData {
  final String name;
  final String country;
  final List<ZoneData> zones;

  const ProvinceData({
    required this.name,
    required this.country,
    required this.zones,
  });
}

class ZoneData {
  final String name;
  final String latestDate;
  final int suspected;
  final int confirmed;
  final int suspectedDeaths;
  final int confirmedDeaths;
  final String cfr;

  int get deaths => suspectedDeaths + confirmedDeaths;

  const ZoneData({
    required this.name,
    required this.latestDate,
    required this.suspected,
    required this.confirmed,
    required this.suspectedDeaths,
    required this.confirmedDeaths,
    required this.cfr,
  });
}
