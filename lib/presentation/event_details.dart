import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';

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
                TeiAttribute?   eventNameAttribute = entity.attributes.firstWhereOrNull(
                      (attr) {
                        return attr.displayName == "Event name" || attr.attribute == "LEAwqoW5Rtc";
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
                              ):Column(
                                children: [
                                  InfoRow(label:"Date detected by MoH:" ,value: moh?.value,),
                                  SizedBox(height: 3),
                                  InfoRow(label:"Date notified to WCO:" ,value: wco?.value,),
                                  SizedBox(height: 3),
                                  InfoRow(label:"Date notified to AFRO:" ,value: afro?.value,),
                                  SizedBox(height: 3),
                                  InfoRow(label:"Start  of reporting period:" ,value: start?.value,),
                                  SizedBox(height: 3),
                                  InfoRow(label:"End of reporting period:" ,value: end?.value,),
                                  SizedBox(height: 6),
                                ],
                              ),


                              Text(
                                "Description:",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              Text(
                                notes??"--",
                                textAlign: TextAlign.justify,
                                style: TextStyle(color: Colors.black,),
                              ),
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
