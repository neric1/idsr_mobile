import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/ebola/ebola_bloc.dart';
import 'package:idsr/application/ebola/ebola_state.dart';



class OutbreakOverviewPage extends StatefulWidget {
  const OutbreakOverviewPage({super.key});

  @override
  State<OutbreakOverviewPage> createState() => _OutbreakOverviewPageState();
}

class _OutbreakOverviewPageState extends State<OutbreakOverviewPage> {
  final List<ProvinceData> data =outbreakData;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return   BlocBuilder<EbolaBloc, EbolaState>(
        builder: (context, state) {

          if (state is EbolaLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EbolaError) {
            return Center(child: Text(state.message));
          }

          if(state is EbolaLoaded){
            final dataResponse=state.data;
            final analyticsRows = dataResponse.rows
                .map((e) => AnalyticsRow.fromList(e))
                .toList();
        return Column(
            children: [
              const OverviewHeaderCard(),
              const SizedBox(height: 16),
              ...data.map((province) => ProvinceSection(province: province)),
              const SizedBox(height: 16),
              const TotalSummaryCard(),
            ],

        );}
          return SizedBox();
      }
    );
  }
}

class OverviewHeaderCard extends StatelessWidget {
  const OverviewHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 5),
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
      margin: const EdgeInsets.only(bottom: 5,),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF2FB),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: const Color(0xFFD7E2F2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5,),
          Text(
            zone.name,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: Color(0xFF1B2430),
            ),
          ),
          const SizedBox(height: 8),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.15,
            children: [
              StatTile(label: 'Suspected', value: '${zone.suspected}'),
              StatTile(label: 'Confirmed', value: '${zone.confirmed}'),
              StatTile(label: 'Deaths', value: '${zone.deaths}'),
              StatTile(label: 'CFR %', value: '${zone.cfr}'),
              // StatTile(label: 'HCW', value: zone.hcw),
              // StatTile(label: 'Recovered', value: '${zone.recoveries}'),
            ],
          ),
          const SizedBox(height: 10),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Row(
          //     children: [
          //       const Icon(Icons.people_alt_outlined, size: 18, color: Color(0xFF2C469A)),
          //       const SizedBox(width: 8),
          //       Text(
          //         'Contacts: ${zone.contacts}',
          //         style: const TextStyle(
          //           fontWeight: FontWeight.w600,
          //           color: Color(0xFF22304A),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
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
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1E2A3A),
            ),
          ),
          // const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
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

class TotalSummaryCard extends StatelessWidget {
  const TotalSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C469A),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 1.2,
            children: const [
              TotalTile(label: 'Suspected', value: '698'),
              TotalTile(label: 'Confirmed', value: '47'),
              TotalTile(label: 'Deaths', value: '6'),
              TotalTile(label: 'CFR %', value: '12.8'),
              // TotalTile(label: 'HCW', value: 'ND'),
              // TotalTile(label: 'Recovered', value: '0'),
            ],
          ),
        ],
      ),
    );
  }
}

class TotalTile extends StatelessWidget {
  final String label;
  final String value;

  const TotalTile({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.12),
        borderRadius: BorderRadius.circular(7),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class ProvinceData {
  final String name;
  final String country;
  final List<ZoneData> zones;

  ProvinceData({
    required this.name,
    required this.country,
    required this.zones,
  });
}

class ZoneData {
  final String name;
  final int suspected;
  final int confirmed;
  final int deaths;
  final String cfr;
  final String hcw;
  final int recoveries;
  final int contacts;

  ZoneData({
    required this.name,
    required this.suspected,
    required this.confirmed,
    required this.deaths,
    required this.cfr,
    required this.hcw,
    required this.recoveries,
    required this.contacts,
  });
}

final List<ProvinceData> outbreakData = [
  ProvinceData(
    name: 'Ituri',
    country: 'DRC',
    zones: [
      ZoneData(name: 'Aungba', suspected: 1, confirmed: 0, deaths: 0, cfr: '0', hcw: 'ND', recoveries: 0, contacts: 0),
      ZoneData(name: 'Bambu', suspected: 7, confirmed: 1, deaths: 0, cfr: '0.0', hcw: 'ND', recoveries: 0, contacts: 0),
      ZoneData(name: 'Bunia', suspected: 128, confirmed: 13, deaths: 2, cfr: '15.4', hcw: 'ND', recoveries: 0, contacts: 0),
      ZoneData(name: 'Fataki', suspected: 3, confirmed: 0, deaths: 0, cfr: '0', hcw: 'ND', recoveries: 0, contacts: 0),
      ZoneData(name: 'Komanda', suspected: 8, confirmed: 0, deaths: 0, cfr: '0', hcw: 'ND', recoveries: 0, contacts: 0),
      ZoneData(name: 'Logo', suspected: 4, confirmed: 0, deaths: 0, cfr: '0', hcw: 'ND', recoveries: 0, contacts: 0),
      ZoneData(name: 'Lolwa', suspected: 1, confirmed: 0, deaths: 0, cfr: '0', hcw: 'ND', recoveries: 0, contacts: 0),
      ZoneData(name: 'Mangala', suspected: 6, confirmed: 0, deaths: 0, cfr: '0', hcw: 'ND', recoveries: 0, contacts: 0),
      ZoneData(name: 'Mongbwalu', suspected: 319, confirmed: 13, deaths: 0, cfr: '0.0', hcw: 'ND', recoveries: 0, contacts: 0),
      ZoneData(name: 'Nizi', suspected: 5, confirmed: 0, deaths: 0, cfr: '0', hcw: 'ND', recoveries: 0, contacts: 0),
      ZoneData(name: 'Nyakunde', suspected: 29, confirmed: 7, deaths: 0, cfr: '0.0', hcw: 'ND', recoveries: 0, contacts: 0),
      ZoneData(name: 'Rwampara', suspected: 176, confirmed: 9, deaths: 3, cfr: '33.3', hcw: 'ND', recoveries: 0, contacts: 0),
    ],
  ),
  ProvinceData(
    name: 'North Kivu',
    country: 'DRC',
    zones: [
      ZoneData(name: 'Butembo', suspected: 4, confirmed: 0, deaths: 0, cfr: '0', hcw: 'ND', recoveries: 0, contacts: 0),
      ZoneData(name: 'Goma', suspected: 5, confirmed: 0, deaths: 0, cfr: '0', hcw: 'ND', recoveries: 0, contacts: 0),
      ZoneData(name: 'Katwa', suspected: 2, confirmed: 2, deaths: 0, cfr: '0.0', hcw: 'ND', recoveries: 0, contacts: 0),
    ],
  ),
  ProvinceData(
    name: 'Kampala',
    country: 'Uganda',
    zones: [
      ZoneData(name: 'Kampala', suspected: 0, confirmed: 2, deaths: 1, cfr: '50.0', hcw: 'ND', recoveries: 0, contacts: 0),
    ],
  ),
];
class AnalyticsRow {
  final String dx;
  final String pe;
  final String ou;
  final double value;

  AnalyticsRow({
    required this.dx,
    required this.pe,
    required this.ou,
    required this.value,
  });

  factory AnalyticsRow.fromList(List<dynamic> row) {
    return AnalyticsRow(
      dx: row[0].toString(),
      pe: row[1].toString(),
      ou: row[2].toString(),
      value: double.tryParse(row[3].toString()) ?? 0,
    );
  }
}