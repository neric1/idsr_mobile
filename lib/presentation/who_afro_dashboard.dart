import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:idsr/application/entity/entity_bloc.dart';
import 'package:idsr/application/signals/signal_bloc.dart';
import 'package:idsr/application/signals/signal_event.dart';
import 'package:idsr/application/signals/signal_state.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';
import 'package:idsr/dependency_injector.dart';
import 'package:idsr/presentation/chart.dart';
import 'package:idsr/presentation/grade_details.dart';
import 'package:idsr/presentation/map.dart';
import 'package:idsr/presentation/marquee.dart';
import 'package:idsr/routes/routes_name.dart';
import 'package:idsr/utils/utils.dart';
import 'package:intl/intl.dart';

import 'filters.dart';

class WhoAfrDashboard extends StatelessWidget {
  const WhoAfrDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(create: (context) => SignalBloc(entityRepository: injector())..add(GetTrackedSignalEvent(programeId: 'E12ZY36aT08')),
      child: Scaffold(
        backgroundColor: const Color(0xFFececec),
        appBar: AppBar(
          elevation: 0,
          title:
        _buildHeader(context) ,
        actions: [      IconButton(
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
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: double.infinity,
                  child:SingleChildScrollView(child: FilterScreenUI())
                // Column(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Text(
                //         "Filters",
                //         style: TextStyle(
                //           fontSize: 18,
                //           fontWeight: FontWeight.w600,
                //           color: Colors.black,
                //         ),
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //   ],
                // ),
              ),
            );
          },
        ),
        ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) {

                  final trackedEntity=context.read<EntityBloc>().trackedEntity;
                  final ongoing= getOngoing(trackedEntity);
                 final grade3= countByGrades(ongoing,"Grade 3",dataElement: "swCuEaReUQr");
                  final grade2= countByGrades(ongoing,"Grade 2",dataElement: "swCuEaReUQr");
                  final grade1= countByGrades(ongoing,"Grade 1",dataElement: "swCuEaReUQr");
                  final ungraded= countByGrades(ongoing,"Ungraded",dataElement: "swCuEaReUQr");

                  final p3= countByGrades(ongoing,"Protracted3",dataElement: "swCuEaReUQr");
                  final p2= countByGrades(ongoing,"Protracted2",dataElement: "swCuEaReUQr");
                  final p1= countByGrades(ongoing,"Protracted1",dataElement: "swCuEaReUQr");

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Signals",
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black),
                        ),
                      ),
                      BlocBuilder(
                        bloc: context.read<SignalBloc>(),
                        builder: (context,state) {

                          final trackedEntity=context.read<SignalBloc>().trackedEntity;
                          // print("object===");
                          // print(trackedEntity.length);
                          if(state is GetTrackedSignalCompleted){
                            final recents=filterByDays(trackedEntity, 14);
                          return InfiniteScrollRow(recents);
                          }
                          return const Center(child: CircularProgressIndicator());
                        }
                      ),
                      SizedBox(height: 10,),
                      BlocBuilder(
                          bloc: context.read<SignalBloc>(),
                          builder: (context,state) {
                            if(state is GetTrackedSignalCompleted){
                              final trackedEntity=context.read<SignalBloc>().trackedEntity;

                              final recents3d=filterByDays(trackedEntity, 3);
                              final recents7d=filterByDays(trackedEntity, 7);
                              final underMonitoring= getUnderMonitoring(trackedEntity);

                              return SizedBox(
                                height: 80,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: _buildSignalCard(trackedEntity, "All",context),
                                    ),
                                    Expanded(
                                      child: _buildSignalCard(recents3d, "Past 3d",context),
                                    ),
                                    Expanded(
                                      child: _buildSignalCard(recents7d, "Past 7d",context),
                                    ),
                                    Expanded(
                                      child: _buildSignalCard(underMonitoring, "Under monitoring",context),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return const Center(child: CircularProgressIndicator());

                        }
                      ),
                      // const SizedBox(height: 14),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Events",
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black),
                        ),
                      ),
                      _buildQuickStats(),
                      // const SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          // color: Color(0xFF28283a),
                          borderRadius: BorderRadius.circular(5),),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                gradeCard(context,grade3,"G3",const Color(0xFFFF2E2E)),
                                gradeCard(context,grade2,"G2",const Color(0xFFFF7A7A)),
                                gradeCard(context,grade1,"G1",const Color(0xFFFFD6D6)),
                                gradeCard(context,ungraded,"UG",const Color(0xFF4A4F58),txtColor: Colors.white)
                              ],
                            ),
                            Row(
                              children: [
                                gradeCard(context,p3,"P3",const Color(0xFFE78A52)),
                                gradeCard(context,p2,"P2",const  Color(0xFFF3C3A3)),
                                gradeCard(context,p1,"P1",const Color(0xFFF7E9D4)),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),
                      SizedBox(
                        height: 300,
                        child: Builder(
                          builder: (context) {
                            final trackedEntity=context.read<EntityBloc>().trackedEntity;
                            final ongoing= getOngoing(trackedEntity);
                            return MyMapWidget(trackedEntity: ongoing);
                          }
                        ),
                      ),
                      SizedBox(height: 20,),
                      _priorityCard(ongoing),
                      const SizedBox(height: 90),
                    ],
                  );
                }
              ),
            ),
          ),
        ),
        // bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // const Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       "WHO AFRO",
        //       style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Color(0xFF4287f5)),
        //     ),
        //     Text(
        //       "IDSR Event Tracker",
        //       style: TextStyle(fontSize: 14,color: Color(0xFF4287f5)),
        //     )
        //   ],
        // ),

        SvgPicture.asset(
          'assets/logo.svg',

          height: 56,
          fit: BoxFit.contain,
          colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
        ),

        GestureDetector(
          onTap: (){

          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Color(0xFF4287f5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              "Epi Week 50, 2025",
              style: TextStyle(color: Colors.white,fontSize: 15),
            ),
          ),
        ),
        // const CircleAvatar(radius: 20, backgroundColor: Colors.grey)
      ],
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      // color: Color(0xFF28283a),
    borderRadius: BorderRadius.circular(5),),
      child: Builder(
        builder: (context) {
          final trackedEntity=context.read<EntityBloc>().trackedEntity;
          final ongoing= getOngoing(trackedEntity);
          final data=getHumanitarianOrOutBreak(ongoing);
          return SizedBox(
            height: 70, // fixed height
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statCard(context,"New Events", [], [Color(0xFF4287f5),Color(0xFF4287f5)]),//nb
                _statCard(context,"Ongoing ", ongoing, [Color(0xFF4287f5),Color(0xFF4287f5)]),
                _statCard(context,"Outbreaks", data[0], [Color(0xFF4287f5),Color(0xFF4287f5)]),
                _statCard(context,"Humanitarian",data[1], [Color(0xFF4287f5),Color(0xFF4287f5)]),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _statCard(BuildContext context,String title, List<TrackedEntity> levels, List<Color> color) {
    return Expanded(
      child: GestureDetector(
        onTap: (){
          context.pushNamed(EVENT_DETAILS,
              extra: {
                "event_name":title,
                "event_list": levels
              });
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => GradeDetails()),
          // );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              colors: color,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                title,
                maxLines: 1,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(levels.length.toString(), style: const TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),

            ],
          ),
        ),
      ),
    );
  }

  Widget gradeCard(
      BuildContext context,
      Map<String, dynamic> grades,
      String title,
      Color color, {
        Color txtColor = const Color(0xFF000000),
      }) {
    return Expanded(
      child: GestureDetector(
        onTap: (){
          context.pushNamed(GRADE_DETAILS,
          extra: {
            "grade_name":title,
            "grade_list": grades
          });
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => GradeDetails()),
          // );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 10),
          child: Stack(
            clipBehavior: Clip.none, // allow overflow
            children: [
              // Main card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 5,top: 2,bottom: 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: txtColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Badge at center-right
              Positioned(
                right: -12,
                top: 0,
                bottom: 0,
                child: Center(
                  child: FractionallySizedBox(
                    heightFactor: 1.5, // 80% of the card height
                    child: AspectRatio(
                      aspectRatio: 1, // keeps it square
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: color, width: 2),
                        ),
                        alignment: Alignment.center,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            grades["totalCount"].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }





  Widget _priorityCard(List<TrackedEntity> trackedEntity) {
    final recent = filterByRecentEvent(trackedEntity, 28);
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
          Text("Recent Events (${recent.length})", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white)),
          SizedBox(height: 10),
          ListView.separated(
            itemCount: recent.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final ent=recent[index];
              Enrollment enrollment=ent.enrollments[0];

              TeiAttribute?   eventNameAttribute = ent.attributes.firstWhereOrNull(
                    (attr) => attr.displayName == "Event name",
                // orElse: () => null,
              );
              TeiAttribute?   eventNoteAttribute = ent.attributes.firstWhereOrNull(
                    (attr) => attr.displayName == "Notes",
                // orElse: () => null,
              );
              TeiAttribute?   evendateAttribute =ent.attributes.firstWhereOrNull(
                    (attr) => attr.attribute == "IXtYxqMzT6W",
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
                   width: MediaQuery.of(context).size.width*0.2,
                  child: Divider(color: Colors.white,)));
          },
          ),

        ],
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
      // final attr=enrollment.attributes;
      // for (final enr in attr) {
      //   print(enrollment.enrollments[0].orgUnitName);
      //   print("objecthhh");
      //   print(enr.toJson());
      // }
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
            dv.value.toLowerCase() == "ongoing" ,
      );
      final isConf =enrollment.attributes.any(
            (dv) =>
        dv.attribute == "z1zytGuFhiM" &&
            dv.value.toLowerCase() == "true",
      );

      if (hasOngoingStatus && !isConf) {

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
Widget _buildSignalCard(List<TrackedEntity> levels, String label,BuildContext context) {
  return
      GestureDetector(
        onTap: (){
          context.pushNamed(EVENT_DETAILS,
              extra: {
                "event_name":label,
                "event_list": levels
              });
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => GradeDetails()),
          // );
        },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const  Color(0xFFF3C3A3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            label,
            maxLines: 2,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: AutoSizeText(NumberFormat('#,###').format(levels.length), style: const TextStyle(color: Color(0xFF153F94), fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          ),

        ],
      ),
    ),
  );
}

List<TrackedEntity> getUnderMonitoring(List<TrackedEntity> trackedEntity) {
  final List<TrackedEntity> ongoingEvents = [];

  for (final enrollment in trackedEntity) {

    final lastEvent=getLastEvent(enrollment.enrollments[0]);

    if(lastEvent!=null){

      final hasOngoingStatus =lastEvent.dataValues.any(
            (dv) =>
        dv.dataElement == "KC59GGouL5n" &&
            dv.value == "Under Monitoring" ,
      );


      if (hasOngoingStatus) {

        ongoingEvents.add(enrollment);
      }
    }
  }

  return ongoingEvents;
}

