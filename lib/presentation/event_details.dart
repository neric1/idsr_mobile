import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';

class EventDetails extends StatelessWidget {
  final String title;
  final List<TrackedEntity> trackedEntities;
   EventDetails({super.key,required this.title,required this.trackedEntities});


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
                              Text(
                                "$notes",
                                style: TextStyle(color: Colors.grey[700]),
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
