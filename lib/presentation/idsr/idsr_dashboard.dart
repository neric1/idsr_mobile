import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/idsr/threshold_bloc.dart';
import 'package:idsr/application/idsr/threshold_event.dart';
import 'package:idsr/application/idsr/threshold_state.dart';
import 'package:idsr/presentation/idsr/threshold_disease_country.dart';
import 'package:idsr/presentation/idsr/threshold_disease_country_details_table.dart';
import 'package:idsr/presentation/who_afro_dashboard.dart';
import 'package:idsr/presentation/widget/disease_threshold_result.dart';
import 'package:idsr/utils/constant.dart';

class IdsrDashboard extends StatelessWidget {
  final String orgunit;
  final String period;

  const IdsrDashboard({
    super.key,
    required this.orgunit,
    required this.period,
  });
  Widget buildViewMore(int remaining,BuildContext c,List<Widget> d) {
    return  ElevatedButton(
      onPressed: () {
        Navigator.push(
          c,
          MaterialPageRoute(
            builder: (context) => ThresholdDiseaseCountry(treshodBloc: c.read<ThresholdBloc>()),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:  Colors.white,
        side: BorderSide(
          color:  Colors.blue,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "+$remaining",
            style:  TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color:Colors.blue,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            "View All",
            style:  TextStyle(fontSize: 12,
              color: Colors.blue,),
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThresholdBloc, ThresholdState>(
      builder: (context, state) {

        if (state is ThresholdLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ThresholdError) {
          return Center(child: Text(state.message));
        }

        if (state is ThresholdLoaded) {
    final b=context.read<ThresholdBloc>();
          final items = state.data.metaData['items'];
          final dx = state.data.metaData['dimensions']['dx'];
          List<Widget> diseaseButtons=[];
          List<Widget> diseaseButtonsAll=[];
          for (var id in dx) {
            final isD=defaultDeases().split(";").contains(id);
          final result = getDiseaseThreshold(
            context: context,
            onButtonClick: (v) {
              context.read<ThresholdBloc>().add(SelectDisease(v));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThresholdDiseaseCountryDetailsTable(treshodBloc:b ),
                ),
              );
            },
            name: items[id]['name'].split("|")[1],
            data: state.data,
            id: id,
          );
            if (result.isOver) {
              diseaseButtonsAll.add(result.button);
            }
          if (result.isOver && isD) {
            diseaseButtons.add(result.button);
          }}

          return Padding(
            padding:  EdgeInsets.symmetric(horizontal: 0.0),
            child: Column(
              children: [

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xff3498db),
                    borderRadius: BorderRadius.circular(5),

                  ),
                  padding: const EdgeInsets.all(10),

                  child: Text(
                    "Disease Threshold Analysis",
                    style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),

                  ),
                ),
                const SizedBox(height: 10),
                 Center(
                   child: BlinkingText(),
                 ),
                const SizedBox(height: 10),
                // SizedBox(
                //   height: 40,
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     children: diseaseButtons,
                //
                //   ),
                // ),
                Wrap(
                  spacing: 8,


                    children:[...diseaseButtons.take(9),
                    buildViewMore(diseaseButtonsAll.length -9,context,diseaseButtons),
                  ]
                  // dx.map<Widget>((id) {
                  //
                  //   final name =
                  //   items[id]['name'].toString().split("|")[1];
                  //
                  //   return ElevatedButton(
                  //     onPressed: () {
                  //       context
                  //           .read<ThresholdBloc>()
                  //           .add(SelectDisease(id));
                  //     },
                  //     child: Text(name),
                  //   );
                  //
                  // }).toList(),
                ),

                const SizedBox(height: 10),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: const Color(0xff3498db).withValues(alpha: 0.4),
                ),
                const SizedBox(height: 10),
                // DiseaseTrendChart(data:state.data),
                // const SizedBox(height: 20),

                //
                // if (state.selectedDisease.isNotEmpty)
                //   SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: DataTable(
                //       columns: const [
                //         DataColumn(label: Text("Country")),
                //         DataColumn(label: Text("Week")),
                //         DataColumn(label: Text("Suspected cases")),
                //       ],
                //       rows: state.filteredRows.map<DataRow>((row) {
                //
                //         return DataRow(cells: [
                //           DataCell(Text(items[row[3]]['name'])),
                //           DataCell(Text(items[row[2]]['name'])),
                //           DataCell(Text(row[4].toString())),
                //         ]);
                //
                //       }).toList(),
                //     ),
                //   )
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}