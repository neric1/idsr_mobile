import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/entity/events/comments_bloc.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';
import 'package:idsr/presentation/widget/timeline.dart';

class SignalsDetails extends StatefulWidget {

  TrackedEntity trackedEntity;
  String? type;
   SignalsDetails({super.key,required this.trackedEntity, this.type});

  @override
  State<SignalsDetails> createState() => _SignalsDetailsState();
}

class _SignalsDetailsState extends State<SignalsDetails> {
   String? sname;
   String? notes;
   String? date;
   TeiAttribute? moh;
   TeiAttribute? wco;
   TeiAttribute? afro;
   TeiAttribute? start;
   TeiAttribute? end;
   TeiAttribute? fullNotesNameAttribute;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final entity=widget.trackedEntity;
    TeiAttribute?   eventNameAttribute = widget.trackedEntity.attributes.firstWhereOrNull(
          (attr) {
        return attr.displayName == "Event name" || attr.attribute == "LEAwqoW5Rtc";
      },
      // orElse: () => null,
    );
    TeiAttribute?   eventNoteAttribute = widget.trackedEntity.attributes.firstWhereOrNull(
          (attr) => attr.displayName == "Notes" || attr.attribute=="WS6ww4XQZko",
      // orElse: () => null,
    );
    TeiAttribute?   dateattribute = widget.trackedEntity.attributes.firstWhereOrNull(
          (attr) =>  attr.attribute=="Zhmz8B6mqEx",
      // orElse: () => null,
    );
       fullNotesNameAttribute = entity.attributes.firstWhereOrNull(
            (attr) {
          return attr.displayName == "Comments";
        },);
        //
      afro =entity.attributes.firstWhereOrNull(
          (attr) => attr.attribute == "IXtYxqMzT6W" || attr.attribute=="Zhmz8B6mqEx",
      // orElse: () => null,
    );

      moh =entity.attributes.firstWhereOrNull(
          (attr) => attr.attribute == "XlwmaCnby7N" || attr.attribute=="Zhmz8B6mqEx",
      // orElse: () => null,
    );
      wco =entity.attributes.firstWhereOrNull(
          (attr) => attr.attribute == "iXgIrStuxGp" || attr.attribute=="Zhmz8B6mqEx",
      // orElse: () => null,
    );
     start =entity.attributes.firstWhereOrNull(
          (attr) => attr.attribute == "dbTjaIcldcW" || attr.attribute=="Zhmz8B6mqEx",
      // orElse: () => null,
    );
      end =entity.attributes.firstWhereOrNull(
          (attr) => attr.attribute == "T0JV2Bo3o2A" || attr.attribute=="Zhmz8B6mqEx",
      // orElse: () => null,
    );

     sname=eventNameAttribute?.value;
     notes=eventNoteAttribute?.value;
     date=dateattribute?.value;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:  AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),   // or context.pop();
          ),
          title:  Center(
            child: Text(
              "$sname",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("${ widget.trackedEntity.enrollments[0].orgUnitName}- $sname",textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

              ),
              Divider(),
             widget.type=="signal"? Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Date of Detection:",style: TextStyle(fontWeight: FontWeight.bold),),
              ):Offstage(),
              widget.type=="signal"?Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${date}"
                  ),
                ),
              ):Offstage(),
              widget.type=="signal"?Offstage():
              TimelineCard(valuemoh: moh?.value,valuewco: wco?.value,valuemafro: afro?.value,valuestart: start?.value,valueend: end?.value,),

          // Column(
              //   children: [
              //     InfoRow(label:"Date detected by MoH:" ,value: moh?.value,),
              //     SizedBox(height: 3),
              //     InfoRow(label:"Date notified to WCO:" ,value: wco?.value,),
              //     SizedBox(height: 3),
              //     InfoRow(label:"Date notified to AFRO:" ,value: afro?.value,),
              //     SizedBox(height: 3),
              //     InfoRow(label:"Start  of reporting period:" ,value: start?.value,),
              //     SizedBox(height: 3),
              //     InfoRow(label:"End of reporting period:" ,value: end?.value,),
              //     SizedBox(height: 6),
              //   ],
              // )

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Description:",style: TextStyle(fontWeight: FontWeight.bold),),
              ),
             notes!=null? Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(notes!
                  ),
                ),
              ):Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text("No Description",style: TextStyle(color: Colors.grey),),
               ),
              SizedBox(height: 10,),
              widget.type=="signal"?Offstage(): Text(
                "Comments:",
                style: TextStyle(fontSize:16,fontWeight: FontWeight.w600),
              ),
              // Text(
              //   notesFull??"--",
              //   textAlign: TextAlign.justify,
              //   style: TextStyle(color: Colors.black,),
              // ),
              widget.type=="signal"?Offstage(): Builder(
                  builder: (context) {

                    final notesFull=fullNotesNameAttribute?.value;

                    final tei=widget.trackedEntity.trackedEntityInstance;
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
              ),
              SizedBox(height: 50,),
            ]),
        ))
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