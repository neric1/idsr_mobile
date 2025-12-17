import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';

class SignalsDetails extends StatefulWidget {

  TrackedEntity trackedEntity;
   SignalsDetails({super.key,required this.trackedEntity});

  @override
  State<SignalsDetails> createState() => _SignalsDetailsState();
}

class _SignalsDetailsState extends State<SignalsDetails> {
   String? sname;
   String? notes;
   String? date;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      body: Center(
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Date of Detection:",style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              Container(
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Short Description:",style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              Container(
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
                  child: Text("$notes"
                  ),
                ),
              )
            ]),
        ))
      );
  }
}
