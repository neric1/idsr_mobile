import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/idsr/threshold_bloc.dart';
import 'package:idsr/application/idsr/threshold_event.dart';
import 'package:idsr/application/idsr/threshold_state.dart';
import 'package:idsr/dependency_injector.dart';
import 'package:idsr/presentation/widget/disease_threshold_result.dart';

class ThresholdDiseaseCountryDetailsTable extends StatelessWidget {
  final ThresholdBloc treshodBloc;

  const ThresholdDiseaseCountryDetailsTable({
    super.key,
    required this.treshodBloc
  });
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder(
      bloc: treshodBloc,
        builder: (context, state) {
          if(state is ThresholdLoaded){
            final items = state.data.metaData['items'];
            List cpe = state.data.metaData['dimensions']['pe'];
            final data=state.filteredRows;
            final rowsData1 = data.where((arr) {
              final value = num.tryParse(arr[4].toString()) ?? 0;
              return arr[2] != cpe[0] && value != 0;
            }).toList();
        return Column(
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
                    "Details for ${items[state.selectedDisease]['name'].split("|")[1]}",
                    style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                      padding:  EdgeInsets.all( 10.0),
                      child:state.selectedDisease.isNotEmpty?
              ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: rowsData1.length,
                itemBuilder: (context, index) {
                  final row = rowsData1[index];

                  final country = items[row[3]]['name'];
                  final week = items[row[2]]['name'];
                  final cases = row[4];

                  final firstWeek=cpe[0];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Top row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              country,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "$cases cases",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 6),

                        /// Week
                        Text(
                          "Week: $week",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ):Offstage()
                    ),
            ),
          ],
        );}
          else{
            return Offstage();
          }
      }
    );


  }
}