import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:idsr/application/entity/entity_bloc.dart';
import 'package:idsr/application/entity/entity_event.dart';
import 'package:idsr/application/entity/entity_state.dart';
import 'package:idsr/application/signals/signal_bloc.dart';
import 'package:idsr/application/signals/signal_event.dart';
import 'package:idsr/application/signals/signal_state.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';
import 'package:idsr/dependency_injector.dart';
import 'package:idsr/presentation/chart.dart';
import 'package:idsr/presentation/grade_details.dart';
import 'package:idsr/presentation/map.dart';
import 'package:idsr/presentation/map_signal.dart';
import 'package:idsr/presentation/marquee.dart';
import 'package:idsr/presentation/week_picker.dart';
import 'package:idsr/presentation/widget/recents_widget.dart';
import 'package:idsr/routes/routes_name.dart';
import 'package:idsr/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:week_of_year/date_week_extensions.dart';

import 'filters.dart';
// Dart class for a country
class CountryOrgUnit {
  final String id;
  final String name;

  CountryOrgUnit({required this.id, required this.name});
}

// List of countries
final List<CountryOrgUnit> countriesOrgUnit = [
  CountryOrgUnit(id: "0", name: "All"),
  CountryOrgUnit(id: 'RL2xfadEX0d', name: "Algeria"),
  CountryOrgUnit(id: 'wI6iMMqyKRY', name: "Angola"),
  CountryOrgUnit(id: 'E5kAKg6J5AH', name: "Benin"),
  CountryOrgUnit(id: 'qsisNWxXBRJ', name: "Botswana"),
  CountryOrgUnit(id: 'CHG4FtC04EF', name: "Burkina Faso"),
  CountryOrgUnit(id: 'cZw3GsPzk8o', name: "Burundi"),
  CountryOrgUnit(id: 'Uf1jZm28TRD', name: "Cape Verde"),
  CountryOrgUnit(id: 'iyafYFo3JMd', name: "Cameroon"),
  CountryOrgUnit(id: 'ZoH5flTZbXw', name: "CAF"),
  CountryOrgUnit(id: 'quwuhdH3jlw', name: "Chad"),
  CountryOrgUnit(id: 'ckFAHLjjv4e', name: "Comoros"),
  CountryOrgUnit(id: 'bUtBmUt1pz6', name: "Congo"),
  CountryOrgUnit(id: 'jCQVCvr10mf', name: "DRC"),
  // CountryOrgUnit(id: '', name: "Djibouti"),
  CountryOrgUnit(id: 'Vpy7G6Pg0bI', name: "Eq. Guinea"),
  CountryOrgUnit(id: 'FPYfp66lui2', name: "Eritrea"),
  CountryOrgUnit(id: 'DssnVxramcD', name: "Eswatini"),
  CountryOrgUnit(id: 'XIDQyXiFXaM', name: "Ethiopia"),
  CountryOrgUnit(id: 'oimhhFE0bb3', name: "Gabon"),
  CountryOrgUnit(id: 'h6qi9TlulbD', name: "Gambia"),
  CountryOrgUnit(id: 'dQU3sezzQ5L', name: "Ghana"),
  CountryOrgUnit(id: 'CVkykjVpChR', name: "Guinea"),
  CountryOrgUnit(id: 'NXkGPH5Twn1', name: "Guinea-Bissau"),
  CountryOrgUnit(id: 'OhZHTN8wn0t', name: "Ivory Coast"),
  CountryOrgUnit(id: 'ciyRYHh9dfs', name: "Kenya"),
  CountryOrgUnit(id: 'jYYR4NWS3t0', name: "Lesotho"),
  CountryOrgUnit(id: 'ywifZLpWkxz', name: "Liberia"),
  // CountryOrgUnit(id: '', name: "Libya"),
  CountryOrgUnit(id: 'ZbAB3ZhhJcQ', name: "Madagascar"),
  CountryOrgUnit(id: 'T5oIRzBIFcp', name: "Malawi"),
  CountryOrgUnit(id: 'jG1AZ4Uelw5', name: "Mali"),
  CountryOrgUnit(id: 'Z7dMsgJHc17', name: "Mauritania"),
  CountryOrgUnit(id: 'Lm31acFuYRp', name: "Mauritius"),
  // CountryOrgUnit(id: '', name: "Morocco"),
  CountryOrgUnit(id: 'Q3LPuIvVmqi', name: "Mozambique"),
  CountryOrgUnit(id: 'zyX24ahbfIm', name: "Namibia"),
  CountryOrgUnit(id: 'auUPRM8dLFo', name: "Niger"),
  CountryOrgUnit(id: 'UnAAMtFzd8j', name: "Nigeria"),
  CountryOrgUnit(id: 'iyQFqn4HHQz', name: "Rwanda"),
  CountryOrgUnit(id: 'j6vs3cZbjQD', name: "STP"),
  CountryOrgUnit(id: 'akKBwZfmuDv', name: "Senegal"),
  CountryOrgUnit(id: 'kfvLKlmzpwN', name: "Seychelles"),
  CountryOrgUnit(id: 'HZtKIozL115', name: "Sierra Leone"),
  // CountryOrgUnit(id: '', name: "Somalia"),
  CountryOrgUnit(id: 'XhcIn2FWihU', name: "South Africa"),
  CountryOrgUnit(id: 'ovvu8SlYevT', name: "South Sudan"),
  // CountryOrgUnit(id: '', name: "Sudan"),
  CountryOrgUnit(id: 'FBp81RH2tMk', name: "Tanzania"),
  CountryOrgUnit(id: 'MUgtTwGrHce', name: "Togo"),
  // CountryOrgUnit(id: '', name: "Tunisia"),
  CountryOrgUnit(id: 'DNMIVXBZt14', name: "Uganda"),
  CountryOrgUnit(id: 'yjrPjSm8VOc', name: "Zambia"),
  CountryOrgUnit(id: 'YDWM8iCX4ZU', name: "Zimbabwe"),
];

class WhoAfrDashboard extends StatefulWidget {
  const WhoAfrDashboard({super.key});

  @override
  State<WhoAfrDashboard> createState() => _WhoAfrDashboardState();
}

class _WhoAfrDashboardState extends State<WhoAfrDashboard>   with WidgetsBindingObserver{
  int isoweek=DateTime.now().weekOfYear;
  DateTime current=DateTime.now();
  DateTime? endDate;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _pageController = PageController();
  }
  final List<String> _tabs = ['Events', 'Signals'];
  late final PageController _pageController;

  int _selectedIndex = 0;



  @override
  void dispose() {
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _onTabTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // if(!mounted)return;
      // final dateEnd=endDate!=null?Jiffy.parseFromDateTime(endDate!)
      //     .format(pattern: 'yyyy-MM-dd'):Jiffy.parseFromDateTime(current)
      //     .format(pattern: 'yyyy-MM-dd');
      // context.read<SignalBloc>()
      //     .add(GetTrackedSignalEvent(programeId: 'E12ZY36aT08&attribute=Zhmz8B6mqEx:GE:2017-01-07:LE:$dateEnd'));
      // context.read<EntityBloc>()
      //     .add(GetTrackedEntityEvent(programeId: 'bG3Arfj8AtF&attribute=IXtYxqMzT6W:GE:1999-12-25:LE:$dateEnd'));

    }
  }

  CountryOrgUnit? selectedCountry;

  Future<CountryOrgUnit?> _openCountryPicker() async {
    final result = await showModalBottomSheet<CountryOrgUnit>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView.separated(
            separatorBuilder: (context, index){
              return Divider(color: Colors.grey,);
            },
            itemCount: countriesOrgUnit.length,
            itemBuilder: (_, index) {
              final country = countriesOrgUnit[index];
              return GestureDetector(
                onTap: () => Navigator.pop(context, country),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                  child: Text(country.name),
                ),
              );
            },
          ),
        );
      },
    );

   return result;
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
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 16),
                  decoration: BoxDecoration(
                    // color: Color(0xFF28283a),
                    borderRadius: BorderRadius.circular(5),),
                  child: Row(
                    children: [
                    Text("Country:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                      SizedBox(width: 5,),
                      Flexible(
                        child: GestureDetector(
                          onTap: () async {
                           final result=await _openCountryPicker();
                           if (result != null) {
                             setState(() => selectedCountry = result);
                             if(!mounted)return;

                             context.read<SignalBloc>()
                                 .add(GetTrackedSignalEvent(programeId: 'E12ZY36aT08',filterLocal: true,countryId: result.id));
                             context.read<EntityBloc>()
                                 .add(GetTrackedEntityEvent(programeId: 'bG3Arfj8AtF',filterLocal: true,countryId: result.id));
                           }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16,),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    selectedCountry?.name ?? 'Select Country',
                                    style: const TextStyle(fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
                  // Text("Country: Ethiopia",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),))
                ,
                /// Tab Bar
                Container(
                  height: 33,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  // padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final tabWidth = constraints.maxWidth / _tabs.length;

                      return Stack(
                        children: [
                          /// Indicator
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 220),
                            curve: Curves.easeOut,
                            left: tabWidth * _selectedIndex,
                            top: 0,
                            bottom: 0,
                            width: tabWidth,
                            child: Container(
                              decoration: BoxDecoration(
                                color:  Color(0xFF4287f5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),

                          /// Tabs
                          Row(
                            children: List.generate(_tabs.length, (index) {
                              final isActive = index == _selectedIndex;

                              return Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () => _onTabTap(index),
                                  child: Center(
                                    child: AnimatedDefaultTextStyle(
                                      duration: const Duration(milliseconds: 180),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: isActive
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                        color: isActive
                                            ? Colors.white
                                            : Colors.grey.shade700,
                                      ),
                                      child: Text(_tabs[index]),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),

                /// PageView
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _selectedIndex = index);
                    },
                    children: [

                    SafeArea(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: BlocBuilder<EntityBloc, EntityState>(
                              builder: (context,mstate) {
                                // final mstate=context.read<EntityBloc>().state;
                                if(mstate is GetTrackedEntityLoading){
                                  return const Center(child: CircularProgressIndicator());
                                }
                                // final trackedEntity=context.read<EntityBloc>().trackedEntity;
                                //)

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

                                    _buildQuickStats(),
                                    const SizedBox(height: 8),
                                    Container(
                                      // padding: EdgeInsets.all(8),
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
                                      height: 350,
                                      child: Builder(
                                          builder: (context) {
                                            final trackedEntity=context.read<EntityBloc>().trackedEntity;
                                            final ongoing= getOngoing(trackedEntity);
                                            return MyMapWidget(trackedEntity: ongoing);
                                          }
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    RecentsCard(ongoing),
                                    const SizedBox(height: 90),
                                  ],
                                );
                              }
                          ),
                        ),
                      ),
                    ),
                     SafeArea(child: SingleChildScrollView(
                       child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             // Padding(
                             //   padding: const EdgeInsets.all(8.0),
                             //   child: Text(
                             //     "Signals",
                             //     style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black),
                             //   ),
                             // ),
                             BlocBuilder(
                                 bloc: context.read<SignalBloc>(),
                                 builder: (context,state) {

                                   final trackedEntity=context.read<SignalBloc>().trackedEntity;
                                   // print("object===");
                                   // print(trackedEntity.length);
                                   if(state is GetTrackedSignalCompleted){
                                     final recents=filterByDays(trackedEntity, 14);
                                     return recents.isNotEmpty? InfiniteScrollRow(recents,"signal"):Offstage();
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
                             // Padding(
                             //   padding: const EdgeInsets.only(top: 8.0,left: 8),
                             //   child: Text(
                             //     "Events",
                             //     style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black),
                             //   ),
                             // ),
                             const SizedBox(height: 20),
                             BlocBuilder(
                                 bloc: context.read<SignalBloc>(),
                                 builder: (context,state) {
                                   if(state is GetTrackedSignalCompleted){
                                 return SizedBox(
                                   height: 400,
                                   child: Builder(
                                       builder: (context) {
                                         final trackedEntity=context.read<SignalBloc>().trackedEntity;
                                         // final ongoing= getOngoing(trackedEntity);
                                         return MyMapSignalWidget(trackedEntity: trackedEntity);
                                       }
                                   ),
                                 );}

                                   return const Center(child: CircularProgressIndicator());
                               }
                             ),

                             SizedBox(height: 20,),
                              BlocBuilder(
                              bloc: context.read<SignalBloc>(),
                              builder: (context,state) {
                              if(state is GetTrackedSignalCompleted){
                                  final trackedEntity=context.read<SignalBloc>().trackedEntity;
                                   return RecentsCard(trackedEntity);}

                              return const Center(child: CircularProgressIndicator());
                               }
                             ),
                             ]

                       ),)))
                    ],
                  ),
                ),
              ],
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
              "Epi Week $isoweek, 2025",
              style: TextStyle(color: Colors.white,fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
    return Container(
      // padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      // color: Color(0xFF28283a),
    borderRadius: BorderRadius.circular(5),),
      child: Builder(
        builder: (context) {
          final trackedEntity=context.read<EntityBloc>().trackedEntity;
          final ongoing= getOngoing(trackedEntity);
          final data=getHumanitarianOrOutBreak(ongoing);

          final recent = filterByRecentEvent(ongoing, 14);
          return Column(
            children: [
            recent.isNotEmpty?  InfiniteScrollRow(recent,"event"):Offstage(),
              SizedBox(height: 8,),
              SizedBox(
                height: 70, // fixed height
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _statCard(context,"New Events", recent, [Color(0xFF4287f5),Color(0xFF4287f5)]),//nb
                    _statCard(context,"Ongoing ", ongoing, [Color(0xFF4287f5),Color(0xFF4287f5)]),
                    _statCard(context,"Outbreaks", data[0], [Color(0xFF4287f5),Color(0xFF4287f5)]),
                    _statCard(context,"Humanitarian",data[1], [Color(0xFF4287f5),Color(0xFF4287f5)]),
                  ],
                ),
              ),
            ],
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

