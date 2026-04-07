import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/entity/events/comments_bloc.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';
import 'package:idsr/presentation/widget/timeline.dart';

class EventDetails extends StatelessWidget {
  final String title;
  final List<TrackedEntity> trackedEntities;
  bool isSignal;
   EventDetails({super.key,required this.title,required this.trackedEntities,this.isSignal=false});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              itemCount: trackedEntities.length,
              itemBuilder: (context, index) {
                final entity=trackedEntities[index];
                final tei=entity.trackedEntityInstance;
                TeiAttribute?   eventNameAttribute = entity.attributes.firstWhereOrNull(
                      (attr) {
                        return attr.displayName == "Event name" || attr.attribute == "LEAwqoW5Rtc";
                      },
                  // orElse: () => null,
                );
                TeiAttribute?   fullNotesNameAttribute = entity.attributes.firstWhereOrNull(
                      (attr) {
                    return attr.displayName == "Comments";
                  },
                  // orElse: () => null,
                );
                TeiAttribute?   eventNoteAttribute = entity.attributes.firstWhereOrNull(
                      (attr) => attr.displayName == "Notes" || attr.attribute=="WS6ww4XQZko",
                  // orElse: () => null,
                );
                TeiAttribute?   afro =entity.attributes.firstWhereOrNull(
                      (attr) => attr.attribute == "IXtYxqMzT6W" || attr.attribute=="Zhmz8B6mqEx",
                  // orElse: () => null,
                );

                TeiAttribute?   moh =entity.attributes.firstWhereOrNull(
                      (attr) => attr.attribute == "XlwmaCnby7N" || attr.attribute=="Zhmz8B6mqEx",
                  // orElse: () => null,
                );
                TeiAttribute?   wco =entity.attributes.firstWhereOrNull(
                (attr) => attr.attribute == "iXgIrStuxGp" || attr.attribute=="Zhmz8B6mqEx",
                // orElse: () => null,
                );
                TeiAttribute?   start =entity.attributes.firstWhereOrNull(
                      (attr) => attr.attribute == "dbTjaIcldcW" || attr.attribute=="Zhmz8B6mqEx",
                  // orElse: () => null,
                );
                TeiAttribute?   end =entity.attributes.firstWhereOrNull(
                      (attr) => attr.attribute == "T0JV2Bo3o2A" || attr.attribute=="Zhmz8B6mqEx",
                  // orElse: () => null,
                );
                TeiAttribute?   dateattribute = entity.attributes.firstWhereOrNull(
                      (attr) =>  attr.attribute=="Zhmz8B6mqEx",
                  // orElse: () => null,
                );
                final eventname=eventNameAttribute?.value;
                final notes=eventNoteAttribute?.value;
                final notesFull=fullNotesNameAttribute?.value;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$eventname",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.flag, size: 16, color: Colors.green),
                                  SizedBox(width: 4),
                                  Text(entity.enrollments[0].orgUnitName),
                                ],
                              ),
                              SizedBox(height: 6),
                              isSignal?Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Expanded(
                                     child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text("Date of Detection:",style: TextStyle(fontWeight: FontWeight.bold),),
                                                                         ),
                                   ),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Text("${dateattribute?.value}"
                                   ),
                                 ),
                                ],
                              ):TimelineCard(valuemoh: moh?.value,valuewco: wco?.value,valuemafro: afro?.value,valuestart: start?.value,valueend: end?.value,),




                              Text(
                                "Description:",
                                style: TextStyle(fontSize:16,fontWeight: FontWeight.w600),
                              ),
                              Text(
                                notes??"--",
                                textAlign: TextAlign.justify,
                                style: TextStyle(color: Colors.black,),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "Comments:",
                                style: TextStyle(fontSize:16,fontWeight: FontWeight.w600),
                              ),
                              // Text(
                              //   notesFull??"--",
                              //   textAlign: TextAlign.justify,
                              //   style: TextStyle(color: Colors.black,),
                              // ),
                              Builder(
                                builder: (context) {
                                  final comments=context.watch<CommentBloc>().comments;
                                  final teiComment=comments.where((comment) => comment.teiId==tei).toList();

                                  List<HumanitarianReport> reports =teiComment;
                                  try{
                                    if(notesFull!=null && notesFull.isNotEmpty)reports.addAll(HumanitarianReport.listFromJson(jsonDecode(notesFull??"")));
                                  }catch(e){
                                    if (kDebugMode) {
                                      print(e.toString());
                                    }
                                  }
                                  return reports.isNotEmpty? Column(
                                    children: reports.map((report) {
                                      return _buildReportCard(report);
                                    }).toList(),
                                  ):Offstage();
                                }
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );


                //   ListTile(
                //   title: Text(entity.enrollments[0].orgUnitName),
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildReportCard(HumanitarianReport report) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFD9CF8B), // light yellow
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (name + date)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE6D88F),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              "${report.storedBy} (${_formatDate(report.storedAt)})",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Content
          Text(
            report.value,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
  String _formatDate(DateTime date) {
    return "${date.year}-${_two(date.month)}-${_two(date.day)}";
  }

  String _two(int n) => n.toString().padLeft(2, '0');
}
class InfoRow extends StatelessWidget {
  final String label;
  final String? value;

  const InfoRow({
    super.key,
    required this.label,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          Text(
            value ?? "-",
            style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
