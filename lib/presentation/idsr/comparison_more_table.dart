import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/idsr/desease_comparison/disease_bloc.dart';
import 'package:idsr/application/idsr/desease_comparison/disease_event.dart';
import 'package:idsr/application/idsr/desease_comparison/disease_state.dart';
import 'package:idsr/data/idsr/models/disease_model.dart';
import 'package:idsr/presentation/week_picker.dart';
import 'package:idsr/utils/constant.dart';
import 'package:idsr/utils/utils.dart';
import 'package:jiffy/jiffy.dart';
import 'package:week_of_year/week_of_year.dart';

class ComparisonMoreTable extends StatefulWidget {
  const ComparisonMoreTable({super.key});

  @override
  State<ComparisonMoreTable> createState() => _ComparisonMoreTableState();
}

class _ComparisonMoreTableState extends State<ComparisonMoreTable> {
  int isoweek=DateTime.now().weekOfYear;
  DateTime current=DateTime.now();
  DateTime currentp=DateTime.now();
  // DateTime? endDate;
  DateTimeRange? rangeDate;
  String  prvwk="";
  String crwk="";
  @override
  void initState() {

    crwk=getPreviousWeek(getPreviousWeek("${current.year}W$isoweek"));
    current=getDateFromWeek(crwk);
    prvwk=getPreviousWeek(getPreviousWeek(getPreviousWeek("${current.year}W$isoweek")));
    currentp=getDateFromWeek(prvwk);
    rangeDate=DateTimeRange(start: Jiffy.parseFromDateTime(current).startOf(Unit.week).dateTime, end: Jiffy.parseFromDateTime(current).endOf(Unit.week).dateTime);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiseaseBloc, DiseaseState>(
      builder: (context, state) {
        if (state is DiseaseLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DiseaseError) {
          return Text("Error: ${state.message}");
        }

        if (state is DiseaseLoaded) {
          final data = state.data;

          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                color: const Color(0xff3498db),
                child: Row(
                  children: [
                    InkWell(onTap: (){
                      Navigator.pop(context);
                    },
                        child: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
                    Text(
                      "More Disease",
                      style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                children: [
                  // const SizedBox(width: 10),
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
                              crwk="${current.year}W$isoweek";
                              // endDate=range.end;
                              rangeDate=range;
                            });

                          },
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Color(0xFF2196f3),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child:  Text(
                        "Epi Week ${crwk.split("W").last}, ${crwk.split("W").first}",
                        style: TextStyle(color: Colors.white,fontSize: 13),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (_) => WeekPickerPopup(
                          initialDate: currentp,
                          onSelected: (range,date) {
                            // print('Week start: ${range.start}');
                            // print('Week end: ${range.end}');
                            setState(() {
                              isoweek=range.end.weekOfYear;
                              currentp=date;
                              prvwk="${currentp.year}W$isoweek";
                              // endDate=range.end;
                              rangeDate=range;
                            });

                          },
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Color(0xFF2196f3),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child:  Text(
                        "Epi Week Before: ${prvwk.split("W").last}, ${prvwk.split("W").first}",
                        style: TextStyle(color: Colors.white,fontSize: 13),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: (){
                      context.read<DiseaseBloc>()
                          .add(FetchDiseaseTrend(country: getOrganizationUnit(),period:  "$prvwk;$crwk",disease: allDeseaseCompare()));
                    },
                    child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Color(0xFFE5E7EB),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.filter_alt_rounded,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Apply",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )),
                  TextButton(
                    onPressed: () {},
                    child: Text("Reset"),
                  )
                ],
              ),
              Expanded(child: _buildMobileList(data.where((element) => element.percentage != 0).toList())),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}
Widget _buildMobileList(List<DiseaseTrend> data) {
  return ListView.builder(
    itemCount: data.length,
    shrinkWrap: true,
    physics: const AlwaysScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      final row = data[index];

      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 1,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(row.name, style:  TextStyle(fontWeight: FontWeight.bold,color: getColor(row.percentage))),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("New: ${row.value}"),
                  Text("Prev: ${row.previous}"),
                  Row(
                    children: [
                      Text("${row.percentage.clamp(-100, 100)}%"),
                      const SizedBox(width: 5),
                      _getTrendIcon(row.percentage),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 6),

            ],
          ),
        ),
      );
    },
  );
}
Widget _getTrendIcon(double percentage) {
  IconData icon;
  Color color;

  if (percentage == 0) {
    icon = Icons.arrow_forward;
    color = const Color(0xFF6e1a17);
  } else if (percentage > 0) {
    icon = Icons.arrow_upward;
    color = const Color(0xFFf2120a);
  } else {
    icon = Icons.arrow_downward;
    color = const Color(0xFF08c945);
  }

  return Icon(icon, color: color, size: 18);
}
DateTime getDateFromWeek(String weekString) {
  final year = int.parse(weekString.substring(0, 4));
  final week = int.parse(weekString.substring(5));

  // ISO week starts Monday
  final firstDayOfYear = DateTime(year, 1, 1);

  // Find first Monday of ISO year
  final daysOffset = firstDayOfYear.weekday <= 4
      ? firstDayOfYear.weekday - 1
      : firstDayOfYear.weekday - 8;

  final firstMonday = firstDayOfYear.subtract(Duration(days: daysOffset));

  return firstMonday.add(Duration(days: (week - 1) * 7));
}
