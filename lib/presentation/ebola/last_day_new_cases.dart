import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/ebola/ebola_bloc.dart';
import 'package:idsr/application/ebola/ebola_state.dart';
import 'package:idsr/data/idsr/models/threshold_model.dart';
import 'package:intl/intl.dart';

const _dxCumulativeConfirmedCases = 'OoZOXclQI7l';
const _dxCumulativeConfirmedDeaths = 'E9dLxqaEL3g';

const _headerColor = Color(0xFF2B4A6B);
const _casesColor = Color(0xFFED7D31);
const _deathsColor = Color(0xFFC9302C);

class DistrictCount {
  final String name;
  final int count;

  const DistrictCount({required this.name, required this.count});
}

class LastDayNewCases {
  final DateTime previousDay;
  final DateTime latestDay;
  final List<DistrictCount> cases;
  final List<DistrictCount> deaths;

  const LastDayNewCases({
    required this.previousDay,
    required this.latestDay,
    required this.cases,
    required this.deaths,
  });

  int get totalCases => cases.fold(0, (sum, d) => sum + d.count);
  int get totalDeaths => deaths.fold(0, (sum, d) => sum + d.count);
  bool get isOneDay => latestDay.difference(previousDay).inHours <= 25;
}

// The daily "new" data elements (frhtqy7Y0Uj, q3cWAxVfVYb) are no longer
// reported, so new counts are the rise in each district's cumulative value
// between the last two reported days.
LastDayNewCases? buildLastDayNewCases(ThresholdModel data) {
  final items = (data.metaData['items'] as Map?) ?? const {};
  final periods = <String>{};
  final valuesByDxOu = <String, Map<String, Map<String, double>>>{
    _dxCumulativeConfirmedCases: {},
    _dxCumulativeConfirmedDeaths: {},
  };

  for (final row in data.rows) {
    if (row is! List || row.length < 4) continue;
    final byOu = valuesByDxOu[row[0].toString()];
    if (byOu == null) continue;

    final pe = row[1].toString();
    final ou = row[2].toString();
    periods.add(pe);
    byOu.putIfAbsent(ou, () => {})[pe] = double.tryParse(row[3].toString()) ?? 0;
  }

  // Two days are needed to compare; a one-day date filter has no baseline.
  if (periods.length < 2) return null;
  final sortedPeriods = periods.toList()..sort();
  final latest = sortedPeriods.last;
  final previous = sortedPeriods[sortedPeriods.length - 2];

  List<DistrictCount> countsFor(String dx) {
    final counts = <DistrictCount>[];
    valuesByDxOu[dx]!.forEach((ou, byPeriod) {
      final latestValue = byPeriod[latest];
      if (latestValue == null) return;

      // A district may have skipped days, so use its own most recent value.
      final earlier = byPeriod.keys.where((pe) => pe.compareTo(latest) < 0).toList()..sort();
      final baseline = earlier.isEmpty ? 0.0 : byPeriod[earlier.last]!;

      // Negative changes are data corrections, not new cases.
      final count = (latestValue - baseline).round();
      if (count <= 0) return;

      final name = (items[ou] as Map?)?['name']?.toString() ?? ou;
      counts.add(DistrictCount(name: name, count: count));
    });
    return counts
      ..sort((a, b) {
        final byCount = b.count.compareTo(a.count);
        return byCount != 0 ? byCount : a.name.compareTo(b.name);
      });
  }

  return LastDayNewCases(
    previousDay: DateTime.parse(previous),
    latestDay: DateTime.parse(latest),
    cases: countsFor(_dxCumulativeConfirmedCases),
    deaths: countsFor(_dxCumulativeConfirmedDeaths),
  );
}

String _formatDateRange(DateTime from, DateTime to) {
  final String start;
  if (from.year != to.year) {
    start = DateFormat('d MMMM y').format(from);
  } else if (from.month != to.month) {
    start = DateFormat('d MMMM').format(from);
  } else {
    start = DateFormat('d').format(from);
  }
  return '$start–${DateFormat('d MMMM y').format(to)}'.toUpperCase();
}

class LastDayNewCasesSection extends StatelessWidget {
  const LastDayNewCasesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EbolaBloc, EbolaState>(
      builder: (context, state) {
        if (state is! EbolaLoaded) return const SizedBox.shrink();

        final summary = buildLastDayNewCases(state.data);
        if (summary == null) return const SizedBox.shrink();

        final window = summary.isOneDay ? 'LAST 24 HOURS' : 'SINCE LAST REPORT';
        final dates = _formatDateRange(summary.previousDay, summary.latestDay);

        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                color: _headerColor,
                child: Text(
                  'NEW CASES – $window ($dates)',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _TotalCard(
                            icon: Icons.shield_outlined,
                            value: summary.totalCases,
                            label: 'NEW CONFIRMED CASES',
                            accentColor: _casesColor,
                            valueColor: _headerColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _TotalCard(
                            icon: Icons.add,
                            value: summary.totalDeaths,
                            label: 'NEW CONFIRMED DEATHS',
                            accentColor: _deathsColor,
                            valueColor: _deathsColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _DistrictCounts(
                      title: 'MAIN AREAS WITH NEW CONFIRMED CASES',
                      counts: summary.cases,
                      color: _casesColor,
                    ),
                    const SizedBox(height: 14),
                    _DistrictCounts(
                      title: 'MAIN AREAS WITH NEW CONFIRMED DEATHS',
                      counts: summary.deaths,
                      color: _deathsColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TotalCard extends StatelessWidget {
  final IconData icon;
  final int value;
  final String label;
  final Color accentColor;
  final Color valueColor;

  const _TotalCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.accentColor,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accentColor),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(color: accentColor, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 17),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '+$value',
                  style: TextStyle(
                    color: valueColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF3D4757),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DistrictCounts extends StatelessWidget {
  final String title;
  final List<DistrictCount> counts;
  final Color color;

  const _DistrictCounts({
    required this.title,
    required this.counts,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF9AA2AF),
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        if (counts.isEmpty)
          const Text(
            'None reported',
            style: TextStyle(color: Color(0xFF6A7483), fontSize: 12),
          )
        else
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: counts.map((d) => _DistrictChip(district: d, color: color)).toList(),
          ),
      ],
    );
  }
}

class _DistrictChip extends StatelessWidget {
  final DistrictCount district;
  final Color color;

  const _DistrictChip({required this.district, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            district.name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            constraints: const BoxConstraints(minWidth: 18),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '${district.count}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
