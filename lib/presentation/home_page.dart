import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/entity/entity_bloc.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';
import 'package:idsr/presentation/grade_details.dart';
import 'package:idsr/presentation/map.dart';
import 'package:idsr/presentation/marquee.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    final events = [
      {'count': '0', 'label': 'New Events'},
      {'count': '109', 'label': 'Ongoing Events'},
      {'count': '88', 'label': 'Outbreaks'},
      {'count': '21', 'label': 'Humanitarian Events'},
    ];
    final List<Map<String, dynamic>> items = [
      {"count": 4, "title": "Grade 3", "color": const Color(0xFFFF2E2E), "textColor": Colors.white},
      {"count": 2, "title": "Grade 2", "color": const Color(0xFFFF7A7A), "textColor": Colors.white},
      {"count": 0, "title": "Grade 1", "color": const Color(0xFFFFD6D6), "textColor": Colors.black87},
      {"count": 40, "title": "Ungraded", "color": const Color(0xFF4A4F58), "textColor": Colors.white},
      {"count": 1, "title": "Protracted 3", "color": const Color(0xFFE78A52), "textColor": Colors.white},
      {"count": 6, "title": "Protracted 2", "color": const Color(0xFFF3C3A3), "textColor": Colors.black87},
      {"count": 0, "title": "Protracted 1", "color": const Color(0xFFF7E9D4), "textColor": Colors.black87},
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      // drawer: Drawer(
      //   child: Container(
      //     width: 200,
      //   ),
      // ),
      appBar: AppBar(
        // leading: Builder(
        //   builder: (context) => IconButton(
        //     icon: const Icon(Icons.filter_list),
        //     onPressed: () {
        //       Scaffold.of(context).openDrawer();
        //     },
        //   ),
        // ),
        backgroundColor: Colors.transparent,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(child: Text("IDSR",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),)),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Example: show a bottom sheet for filters
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) =>  SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Filters",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            final trackedEntity=context.read<EntityBloc>().trackedEntity;
           final ongoing= getOngoing(trackedEntity);
           final data=getHumanitarianOrOutBreak(ongoing);

            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InfiniteScrollRow(),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2, // 2 columns
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.4,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: _buildEventCard(data[2].length.toString(), "New Events"),
                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: _buildEventCard(ongoing.length.toString(), "Ongoing Events"),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: _buildEventCard(data[0].length.toString(), "Outbreaks"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: _buildEventCard(data[1].length.toString(), "Humanitarian Events"),
                        ),
                      ],
                    ),
                    // GridView.builder(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   itemCount: events.length,
                    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2, // 2 columns
                    //     crossAxisSpacing: 12,
                    //     mainAxisSpacing: 12,
                    //     childAspectRatio: 1.4,
                    //   ),
                    //   itemBuilder: (context, index) {
                    //     final e = events[index];
                    //     return Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //       child: _buildEventCard(e['count']!, e['label']!),
                    //     );
                    //   },
                    // ),
                    const SizedBox(height: 16),
                     SizedBox(
                      height: 500,
                      child: MyMapWidget(),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: buildItem(count: 8, color: const Color(0xFFFF2E2E), title: "Grade 3"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: buildItem(count: 10, color:  const Color(0xFFFF7A7A), title: "Grade 2"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: buildItem(count: 4, color: const Color(0xFFFFD6D6), title: "Grade 1"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: buildItem(count: 30, color: const Color(0xFF4A4F58), title: "Ungraded",textColor:Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: buildItem(count: 5, color: const Color(0xFFE78A52), title: "Protracted 3"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: buildItem(count: 12, color: const Color(0xFFF3C3A3), title: "Protracted 2"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: buildItem(count: 17, color: const Color(0xFFF7E9D4), title: "Protracted 1"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    // GridView.builder(
                    //   itemCount: items.length,
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 3,       // ➜ 3 per row
                    //     crossAxisSpacing: 12,
                    //     mainAxisSpacing: 12,
                    //     childAspectRatio: 0.85,  // height control
                    //   ),
                    //   itemBuilder: (context, index) {
                    //     final item = items[index];
                    //     return EventGridBox(
                    //       count: item["count"],
                    //       title: item["title"],
                    //       color: item["color"],
                    //       textColor: item["textColor"],
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            );
          }
        ),
      )

    );
  }
  Widget _buildEventCard(String count, String label) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AutoSizeText(
              label,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              count,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 38,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        ],
      ),
    );
  }
  Widget buildItem({
    required int count,
    required Color color,
    required String title,
    Color textColor= const Color(0xFF000000)
  }){
    return   GestureDetector(
      onTap: (){
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => GradeDetails()),
        // );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        decoration: BoxDecoration(
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    count.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right,size: 30,color: textColor,)
          ],
        ),
      ),
    );
  }
}



List<List<TrackedEntity>> getHumanitarianOrOutBreak(List<TrackedEntity> ongoing,{String v="humanitarian"}) {
  final List<TrackedEntity> HTEvents = [];
  final List<TrackedEntity> OBEvents = [];
  final List<TrackedEntity> unknown = [];
  for (final enrollment in ongoing) {




    final isHT =enrollment.attributes.any(
          (dv) =>
      dv.attribute == "jLHBfRluNTt" &&
          dv.value.toLowerCase() == "humanitarian",
    );

    final isOB =enrollment.attributes.any(
          (dv) =>
      dv.attribute == "jLHBfRluNTt" &&
          dv.value.toLowerCase() == "outbreak",
    );

    if (isHT) {
      HTEvents.add(enrollment);
    }
    else if (isOB) {
      OBEvents.add(enrollment);
    }else{
      final attr=enrollment.attributes;
      for (final enr in attr) {
        print(enrollment.enrollments[0].orgUnitName);
        print("objecthhh");
        print(enr.toJson());
      }
      unknown.add(enrollment);
    }

  }
  return [OBEvents,HTEvents,unknown];
}

List<TrackedEntity> getOngoing(List<TrackedEntity> trackedEntity) {
  final List<TrackedEntity> ongoingEvents = [];

  for (final enrollment in trackedEntity) {

    final lastEvent=getLastEvent(enrollment.enrollments[0]);

        if(lastEvent!=null){

     final hasOngoingStatus =lastEvent.dataValues.any(
            (dv) =>
        dv.dataElement == "aC8lzAvYHdh" &&
            dv.value.toLowerCase() == "ongoing",
      );

      if (hasOngoingStatus) {
        ongoingEvents.add(enrollment);
      }
}
  }

  return ongoingEvents;
}

EventItem? getLastEvent(Enrollment? enrollment) {
  if (enrollment == null || enrollment.events.isEmpty) {
    return null;
  }

  List<EventItem> events = enrollment.events;

  // Sort events by created date
  events.sort((a, b) {
    DateTime dateA = DateTime.parse(a.created);
    DateTime dateB = DateTime.parse(b.created);
    return dateA.compareTo(dateB);
  });

    return events.isNotEmpty ? events.last : null;

}

class EventGridBox extends StatelessWidget {
  final int count;
  final String title;
  final Color color;
  final Color textColor;

  const EventGridBox({
    super.key,
    required this.count,
    required this.title,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$count",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}