import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';

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
              widget.type=="signal"?Offstage(): Column(
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
              )
              ,
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

            ]),
        ))
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