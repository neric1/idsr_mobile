import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idsr/application/entity/entity_bloc.dart';
import 'package:idsr/application/entity/entity_event.dart';
import 'package:idsr/application/signals/signal_bloc.dart';
import 'package:idsr/application/signals/signal_event.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';
import 'package:idsr/presentation/messages/Messages.dart';
import 'package:idsr/presentation/reports/reports.dart';
import 'package:idsr/presentation/settings/settings.dart';
import 'package:idsr/presentation/week_picker.dart';
import 'package:idsr/presentation/who_afro_dashboard.dart';
import 'package:jiffy/jiffy.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:week_of_year/date_week_extensions.dart';

import 'idsr/idsr.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int isoweek=DateTime.now().weekOfYear;
  DateTime current=DateTime.now();
  DateTime? endDate;
  DateTimeRange? rangeDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rangeDate=DateTimeRange(start: Jiffy.parseFromDateTime(current).startOf(Unit.week).dateTime, end: Jiffy.parseFromDateTime(current).endOf(Unit.week).dateTime);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        backgroundColor: const Color(0xFFececec),
        appBar: AppBar(
          elevation: 0,
          title:
          _buildHeader(context) ,
          actions: [

            GestureDetector(
                onTap: (){
                  final dateEnd=endDate!=null?Jiffy.parseFromDateTime(endDate!)
                      .format(pattern: 'yyyy-MM-dd'):Jiffy.parseFromDateTime(current)
                      .format(pattern: 'yyyy-MM-dd');
                  context.read<SignalBloc>()
                      .add(GetTrackedSignalEvent(programeId: 'E12ZY36aT08&attribute=Zhmz8B6mqEx:GE:2017-01-07:LE:$dateEnd'));
                  context.read<EntityBloc>()
                      .add(GetTrackedEntityEvent(programeId: 'bG3Arfj8AtF&attribute=IXtYxqMzT6W:GE:1999-12-25:LE:$dateEnd'));

                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Icon(Icons.sync,color: Colors.red,),
                )),


            //   IconButton(
            //   icon: const Icon(Icons.filter_list),
            //   onPressed: () {
            //     // Example: show a bottom sheet for filters
            //     showModalBottomSheet(
            //       isScrollControlled: true,
            //       context: context,
            //       shape: const RoundedRectangleBorder(
            //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            //       ),
            //       builder: (context) =>  SizedBox(
            //           height: MediaQuery.of(context).size.height * 0.9,
            //           width: double.infinity,
            //           child:SingleChildScrollView(child: FilterScreenUI())
            //         // Column(
            //         //   children: [
            //         //     Padding(
            //         //       padding: const EdgeInsets.all(8.0),
            //         //       child: Text(
            //         //         "Filters",
            //         //         style: TextStyle(
            //         //           fontSize: 18,
            //         //           fontWeight: FontWeight.w600,
            //         //           color: Colors.black,
            //         //         ),
            //         //         textAlign: TextAlign.center,
            //         //       ),
            //         //     ),
            //         //   ],
            //         // ),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      body: PersistentTabView(
        tabs: [
          PersistentTabConfig(
            screen: WhoAfrDashboard(),
            item: ItemConfig(
              icon: Icon(Icons.event),
              title: "S&E",
            ),
          ),
          PersistentTabConfig(
            screen:Idsr() ,
            item: ItemConfig(
              icon: Icon(Icons.medical_services),
              title: "IDSR",
            ),
          ),
          PersistentTabConfig(
            screen:Messages() ,
            item: ItemConfig(
              icon: Icon(Icons.message),
              title: "Messages",
            ),
          ),
          PersistentTabConfig(
            screen: Reports(),
            item: ItemConfig(
              icon: Icon(Icons.stacked_bar_chart),
              title: "Reports",
            ),
          ),
          PersistentTabConfig(
            screen:Settings() ,
            item: ItemConfig(
              icon: Icon(Icons.settings),
              title: "Settings",
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style7BottomNavBar(
          // navBarDecoration: NavBarDecoration(
          //   color: Colors.blue.withValues(alpha: 0.3),
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.black26,
          //       blurRadius: 10,
          //     ),
          //   ],
          // ),
          navBarConfig: navBarConfig,
        ),
      )

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

        Column(
          children: [
            GestureDetector(
              onTap: (){
                showDialog(
                  context: context,
                  builder: (_) => WeekPickerPopup(
                    initialDate: current,
                    onSelected: (range,date) {
                      // print('Week start: ${range.start}');
                      // print('Week end: ${range.end}');
                      setState(() {
                        isoweek=range.end.weekOfYear;
                        current=date;
                        endDate=range.end;
                        rangeDate=range;
                      });
                      final dateEnd=Jiffy.parseFromDateTime(range.end)
                          .format(pattern: 'yyyy-MM-dd');
                      context.read<SignalBloc>()
                          .add(GetTrackedSignalEvent(programeId: 'E12ZY36aT08&attribute=Zhmz8B6mqEx:GE:2017-01-07:LE:$dateEnd'));
                      context.read<EntityBloc>()
                          .add(GetTrackedEntityEvent(programeId: 'bG3Arfj8AtF&attribute=IXtYxqMzT6W:GE:1999-12-25:LE:$dateEnd'));
                    },
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Color(0xFF4287f5),
                  borderRadius: BorderRadius.circular(14),
                ),
                child:  Text(
                  "Epi Week $isoweek, ${rangeDate!.end.year}",
                  style: TextStyle(color: Colors.white,fontSize: 15),
                ),
              ),
            ),
            rangeDate!=null?Text(getWeekRangeText(rangeDate!.start,rangeDate!.end),style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.w400),):Offstage()
          ],
        ),
      ],
    );
  }
  String getWeekRangeText(DateTime start, DateTime end) {

    // If same month
    if (start.month == end.month && start.year == end.year) {
      return " ${start.day} - ${end.day} "
          "${Jiffy.parseFromDateTime(end).format(pattern: "MMM yyyy")}";
    }

    // If different month or year
    return "${Jiffy.parseFromDateTime(start).format(pattern: "d MMM")} "
        "- ${Jiffy.parseFromDateTime(end).format(pattern: "d MMM yyyy")}";
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