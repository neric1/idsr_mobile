
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';

import 'package:idsr/data/entity/models/tracked_entity.dart';
import 'package:idsr/utils/utils.dart';

Widget RecentsCard(List<TrackedEntity> trackedEntity,{required String title}) {
  final recent = filterByDays(trackedEntity, 100).take(5).toList();
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF4287F5),
          Color(0xFF153F94),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Text("Recent $title (${recent.length})", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white)),
        SizedBox(height: 10),
        ListView.separated(
          itemCount: recent.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final ent=recent[index];
            Enrollment enrollment=ent.enrollments[0];

            TeiAttribute?   eventNameAttribute = ent.attributes.firstWhereOrNull(
                  (attr) => attr.displayName == "Event name" || attr.attribute == "LEAwqoW5Rtc" ,
              // orElse: () => null,
            );
            TeiAttribute?   eventNoteAttribute = ent.attributes.firstWhereOrNull(
                  (attr) => attr.displayName == "Notes" || attr.attribute=="WS6ww4XQZko",
              // orElse: () => null,
            );
            TeiAttribute?   evendateAttribute =ent.attributes.firstWhereOrNull(
                  (attr) => attr.attribute == "IXtYxqMzT6W" || attr.attribute=="Zhmz8B6mqEx",
              // orElse: () => null,
            );
            final eventdate=evendateAttribute?.value;
            final eventname=eventNameAttribute?.value;
            final notes=eventNoteAttribute?.value;
            return  Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text("$eventname | ${enrollment.orgUnitName}",style: TextStyle(color: Colors.white,fontWeight:FontWeight.w600,fontSize: 14),)),

                      ],
                    ),
                    Text("$eventdate",style: TextStyle(color: Colors.white.withValues(alpha: 0.5),fontSize: 11),),
                    Text("$notes",style: TextStyle(color: Colors.white,fontSize: 11),),

                  ]

              ),
            );
          }, separatorBuilder: (BuildContext context, int index) {
          return Center(child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Divider(color: Colors.white,)));
        },
        ),

      ],
    ),
  );
}