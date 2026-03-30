import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/idsr/threshold_bloc.dart';
import 'package:idsr/application/idsr/threshold_event.dart';
import 'package:idsr/application/idsr/threshold_state.dart';
import 'package:idsr/dependency_injector.dart';
import 'package:idsr/presentation/idsr/threshold_disease_country_details_table.dart';
import 'package:idsr/presentation/widget/disease_threshold_result.dart';

class ThresholdDiseaseCountry extends StatelessWidget {

  final ThresholdBloc treshodBloc;


  const ThresholdDiseaseCountry({
    super.key,
    required this.treshodBloc
  });
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder(
         bloc: treshodBloc,
        builder: (context, state) {
          if (state is ThresholdLoaded) {

            final items = state.data.metaData['items'];
            final dx = state.data.metaData['dimensions']['dx'];
            List<Widget> diseaseButtons=[];
            for (var id in dx) {
              final result = getDiseaseThreshold(
                context: context,
                onButtonClick: (v) {

                  treshodBloc.add(SelectDisease(v));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThresholdDiseaseCountryDetailsTable(treshodBloc: treshodBloc),
                    ),
                  );
                },
                name: items[id]['name'].split("|")[1],
                data: state.data,
                id: id,
              );

              if (result.isOver) {
                diseaseButtons.add(result.button);
              }}
        return Padding(
                padding:  EdgeInsets.symmetric(horizontal: 0.0),
                child: Column(
                  children: [

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      color: const Color(0xff3498db),
                      child: Row(
                        children: [
                          InkWell(onTap: (){
                            Navigator.pop(context);
                          },
                              child: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
                          Text(
                            "Disease Threshold Analysis",
                            style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),
                    // SizedBox(
                    //   height: 40,
                    //   child: ListView(
                    //     scrollDirection: Axis.horizontal,
                    //     children: diseaseButtons,
                    //
                    //   ),
                    // ),
                    Expanded(
                      child: SingleChildScrollView(

                        child: Wrap(
                          spacing: 8,


                            children:diseaseButtons,

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
                      ),
                    ),

                    const SizedBox(height: 20),

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
              );}else{
            return Offstage();
          }
      }
    );


  }
}