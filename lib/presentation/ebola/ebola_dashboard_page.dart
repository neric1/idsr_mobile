import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/ebola/ebola_bloc.dart';
import 'package:idsr/application/ebola/ebola_event.dart';
import 'package:idsr/application/ebola/ebola_state.dart';
import 'package:idsr/presentation/ebola/overview_table.dart';
import 'package:idsr/utils/constant.dart';
import 'package:idsr/utils/utils.dart';

class EbolaDashboardPage extends StatefulWidget {
  const EbolaDashboardPage({super.key});

  @override
  State<EbolaDashboardPage> createState() => _EbolaDashboardPageState();
}

class _EbolaDashboardPageState extends State<EbolaDashboardPage> with SingleTickerProviderStateMixin {
  String per=generateDateRangeString("20260501");

      //"20260101;20260102;20260103;20260104;20260105;20260106;20260107;20260108;20260109;20260110;20260111;20260112;20260113;20260114;20260115;20260116;20260117;20260118;20260119;20260120;20260121;20260122;20260123;20260124;20260125;20260126;20260127;20260128;20260129;20260130;20260131;20260201;20260202;20260203;20260204;20260205;20260206;20260207;20260208;20260209;20260210;20260211;20260212;20260213;20260214;20260215;20260216;20260217;20260218;20260219;20260220;20260221;20260222;20260223;20260224;20260225;20260226;20260227;20260228;20260301;20260302;20260303;20260304;20260305;20260306;20260307;20260308;20260309;20260310;20260311;20260312;20260313;20260314;20260315;20260316;20260317;20260318;20260319;20260320;20260321;20260322;20260323;20260324;20260325;20260326;20260327;20260328;20260329;20260330;20260331;20260401;20260402;20260403;20260404;20260405;20260406;20260407;20260408;20260409;20260410;20260411;20260412;20260413;20260414;20260415;20260416;20260417;20260418;20260419;20260420;20260421;20260422;20260423;20260424;20260425;20260426;20260427;20260428;20260429;20260430;20260501;20260502;20260503;20260504;20260505;20260506;20260507;20260508;20260509;20260510;20260511;20260512;20260513;20260514;20260515;20260516;20260517;20260518;20260519;20260520;20260521;20260522";

  late TabController _tabController;

  final List<String> tabs = ["CUMULATIVE CASES", "NEW CASES"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: 0,
    );

    context.read<EbolaBloc>()
        .add(LoadEbola(getOrganizationUnitOfEbola(), per));
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {});
    });

  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  DateTime startDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    1,
  );
  void goToTab(int index) {
    _tabController.animateTo(index);
    setState(() {});
  }
  DateTime endDate = DateTime.now();

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
  Future<void> pickDate({
    required BuildContext context,
    required bool isStart,
  }) async {

    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? startDate : endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {

        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }

      });
    }
  }
  String getDateRangeString(DateTime startDate, DateTime endDate) {
    final dates = <String>[];
    DateTime current = startDate;

    while (!current.isAfter(endDate)) {
      final formatted =
          '${current.year}'
          '${current.month.toString().padLeft(2, '0')}'
          '${current.day.toString().padLeft(2, '0')}';

      dates.add(formatted);
      current = current.add(const Duration(days: 1));
    }

    return dates.join(';');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFececec),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade800,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: const Text(
                "EBOLA BUNDIBUGYO VIRUS DISEASE Democratic Republic of the Congo (DRC) and Uganda",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Colors.white
                ),
              ),
            ),

            const SizedBox(height: 10),

            // FILTERS
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      pickDate(
                        context: context,
                        isStart: true,
                      );
                    },
                    child: _buildInputField(
                      title: "Start date",
                      hint: formatDate(startDate),
                      suffixIcon: Icons.calendar_today_outlined,
                    ),
                  ),
                ),

                 Container( padding:EdgeInsets.symmetric(horizontal: 4), width: 30,child: Text(
             "To",
      style:  TextStyle(
        fontWeight: FontWeight.w700,
      ),
    )),

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      pickDate(
                        context: context,
                        isStart: false,
                      );
                    },
                    child: _buildInputField(
                      title: "End date",
                      hint: formatDate(endDate),
                      suffixIcon: Icons.calendar_today_outlined,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                        onTap: (){
                          context.read<EbolaBloc>()
                              .add(LoadEbola(getOrganizationUnitOfEbola(), getDateRangeString(startDate, endDate)));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            color: Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Color(0xff35afe6),
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
                  ],
                ),
              ],
            ),
            SizedBox(height: 5,),
            //
            // const SizedBox(height: 20),

            // CONTENT
            BlocBuilder<EbolaBloc, EbolaState>(
                builder: (context, state) {

                  if (state is EbolaLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is EbolaError) {
                    return Center(child: Text(state.message));
                  }

                  if(state is EbolaLoaded){
                    final data=state.data;
                    final rows = data.rows;
                    final explicitUgandaOuIds = <String>[
                      // Add Uganda OU IDs here if needed for strict mapping.
                      "U3R3kc9XuaE"
                    ];
                    final analyticsRows = rows
                        .map((e) => AnalyticsRow.fromList(e))
                        .toList();
                    final analyticsRowsUg = rows
                        .map((e) => AnalyticsRow.fromList(e))
                        .toList().where((t)=>explicitUgandaOuIds.contains(t.ou)).toList();
                    final analyticsRowsDRC = rows
                        .map((e) => AnalyticsRow.fromList(e))
                        .where((t) => !explicitUgandaOuIds.contains(t.ou))
                        .toList();
                    final items = data.metaData['items'];
                    final ouNameHierarchy = data.metaData['ouNameHierarchy'];

                    // ── Country grouping (Uganda vs DRC) ──────────────────

                    // final ugandaKeywords = <String>{
                    //   'uganda',
                    //   'kampala',
                    //   'wakiso',
                    //   'mbale',
                    //   'mubende',
                    //   'kasese',
                    //   'bundibugyo',
                    //   'fort portal',
                    //   'kyegegwa',
                    //   'kyenjojo',
                    //   'kagadi',
                    //   'hoima',
                    // };

                    // bool isUgandaOu(String ouId) {
                    //  return explicitUgandaOuIds.contains(ouId);
                      // final ouName =
                      // (items[ouId]?['name']?.toString().toLowerCase() ?? '');
                      // return ugandaKeywords.any(ouName.contains);
                    // }
                    bool isUgandaOu(String id) {
                      final location = ouNameHierarchy[id];

                      if (location == null) {
                        return false;
                      }

                      return location.startsWith('/Africa Region/Uganda/') ||location.startsWith('/Uganda/');
                    }

                    bool isUgandaRow(AnalyticsRow r) => isUgandaOu(r.ou);

                    // ── Helper: sum data element by country and period ─────
                    double sumDx({
                      required String dxId,
                      required bool uganda,
                      String? period,
                    }) => analyticsRows
                        .where(
                          (r) =>
                      r.dx == dxId &&
                          isUgandaRow(r) == uganda &&
                          (period == null || r.pe == period),
                    )
                        .fold(0.0, (s, r) => s + r.value);

                    int zonesCount({
                      required bool uganda,
                      String? period,
                    }) => analyticsRows
                        .where(
                          (r) => isUgandaRow(r) == uganda &&
                          (period == null || r.pe == period) && r.value>0 &&( r.dx== "OoZOXclQI7l" ||r.dx== "E9dLxqaEL3g" ) && items[r.ou]["name"]!="Unknown",
                    )
                        .map((r) => r.ou)
                        .toSet()
                        .length;

                    // ── Latest period ──────────────────────────────────────
                    final allPeriodsUg = analyticsRowsUg.map((r) => r.pe).toSet().toList()..sort();
                    final allPeriodsDRC = analyticsRowsDRC.map((r) => r.pe).toSet().toList()..sort();
                    final latestPeriodUg = allPeriodsUg.isNotEmpty ? allPeriodsUg.last : '';
                    final latestPeriodDRC = allPeriodsDRC.isNotEmpty ? allPeriodsDRC.last : '';
                    final now = DateTime.now();
                    final todayPeriod =
                        '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';

                    String fmt(double v) => v.toStringAsFixed(0);

                    String periodToDate(String p) => p.length == 8
                        ? '${p.substring(6, 8)}/${p.substring(4, 6)}/${p.substring(0, 4)}'
                        : p;

                    // ── CUMULATIVE values ──────────────────────────────────
                    // CCBkZTKOOBi = Number of Probable Cases  (Suspected)
                    // frhtqy7Y0Uj = Confirmed cases (Newly confirmed)
                    // p8aIQHxhYpJ = Total Deaths              (Suspected Deaths)
                    // q3cWAxVfVYb = New deaths among confirmed cases

                  //   "OoZOXclQI7l": "Cummulative Confirmed Cases ",
                  // "E9dLxqaEL3g": "Cummulative Confirmed Deaths",
                  // "A8p2Spxdtg1": "Cummulative Suspected Deaths",
                  // "kdSei0GD1mM": "Cummulative Suspected Cases ",

                    final drcCumulSuspected = fmt(sumDx(dxId: 'kdSei0GD1mM',period: latestPeriodDRC, uganda: false)); // "kdSei0GD1mM": "Cummulative Suspected Cases ",
                    final drcCumulConfirmed = sumDx(dxId: 'OoZOXclQI7l',period: latestPeriodDRC, uganda: false);//   "OoZOXclQI7l": "Cummulative Confirmed Cases ",
                    final drcCumulSuspDead = fmt(sumDx(dxId: 'A8p2Spxdtg1',period: latestPeriodDRC, uganda: false));// "A8p2Spxdtg1": "Cummulative Suspected Deaths",
                    final drcCumulConfDead = sumDx(dxId: 'E9dLxqaEL3g',period: latestPeriodDRC, uganda: false);// "E9dLxqaEL3g": "Cummulative Confirmed Deaths",
                    final drcCumulConfVal = sumDx(dxId: 'frhtqy7Y0Uj', uganda: false);
                    final drcCumulDeadVal = sumDx(dxId: 'q3cWAxVfVYb', uganda: false);
                    final drcCumulCfr = drcCumulConfirmed > 0
                        ? '${(drcCumulConfDead / drcCumulConfirmed * 100).toStringAsFixed(1)}%'
                        : '0.0%';
                    final drcHealthZones = zonesCount(uganda: false).toString();

                    final ugaCumulSuspected = fmt(sumDx(dxId: 'kdSei0GD1mM',period: latestPeriodUg, uganda: true));
                    final ugaCumulConfirmed = sumDx(dxId: 'OoZOXclQI7l',period: latestPeriodUg, uganda: true);
                    final ugaCumulSuspDead = fmt(sumDx(dxId: 'A8p2Spxdtg1',period: latestPeriodUg, uganda: true));
                    final ugaCumulConfDead = sumDx(dxId: 'E9dLxqaEL3g',period: latestPeriodUg, uganda: true);
                    final ugaCumulConfVal = sumDx(dxId: 'frhtqy7Y0Uj', uganda: true);
                    final ugaCumulDeadVal = sumDx(dxId: 'q3cWAxVfVYb', uganda: true);
                    final ugaCumulCfr = ugaCumulConfirmed > 0
                        ? '${(ugaCumulConfDead / ugaCumulConfirmed * 100).toStringAsFixed(1)}%'
                        : '0.0%';
                    final ugaDistricts = zonesCount(uganda: true).toString();

                    // ── TODAY (latest period) values ───────────────────────
                    // VqZJorqoYGG = Suspected cases today
                    // dnKH6OmmNQ7 = Suspected cases today Dead


                    final drcTodaySuspected = fmt(sumDx(
                      dxId: 'CCBkZTKOOBi',
                      uganda: false,
                      period: latestPeriodDRC,
                    ));
                    final drcTodayConfirmed = fmt(sumDx(
                      dxId: 'frhtqy7Y0Uj',
                      uganda: false,
                      period: latestPeriodDRC,
                    ));
                    final drcTodaySuspDead = fmt(sumDx(
                      dxId: 'dnKH6OmmNQ7',
                      uganda: false,
                      period: latestPeriodDRC,
                    ));
                    final drcTodayConfDead = fmt(sumDx(
                      dxId: 'q3cWAxVfVYb',
                      uganda: false,
                      period: latestPeriodDRC,
                    ));
                    final drcTodayConfVal = sumDx(
                      dxId: 'frhtqy7Y0Uj',
                      uganda: false,
                      period: latestPeriodDRC,
                    );
                    final drcTodayDeadVal = sumDx(
                      dxId: 'q3cWAxVfVYb',
                      uganda: false,
                      period: latestPeriodDRC,
                    );
                    final drcTodayCfr = drcTodayConfVal > 0
                        ? '${(drcTodayDeadVal / drcTodayConfVal * 100).toStringAsFixed(1)}%'
                        : '0.0%';
                    final drcTodayZones =
                    zonesCount(uganda: false, period: latestPeriodDRC).toString();

                    final ugaTodaySuspected = fmt(sumDx(
                      dxId: 'VqZJorqoYGG',
                      uganda: true,
                      period: latestPeriodUg,
                    ));
                    final ugaTodayConfirmed = fmt(sumDx(
                      dxId: 'frhtqy7Y0Uj',
                      uganda: true,
                      period: latestPeriodUg,
                    ));
                    final ugaTodaySuspDead = fmt(sumDx(
                      dxId: 'dnKH6OmmNQ7',
                      uganda: true,
                      period: latestPeriodUg,
                    ));
                    final ugaTodayConfDead = fmt(sumDx(
                      dxId: 'q3cWAxVfVYb',
                      uganda: true,
                      period: latestPeriodUg,
                    ));
                    final ugaTodayConfVal = sumDx(
                      dxId: 'frhtqy7Y0Uj',
                      uganda: true,
                      period: latestPeriodUg,
                    );
                    final ugaTodayDeadVal = sumDx(
                      dxId: 'q3cWAxVfVYb',
                      uganda: true,
                      period: latestPeriodUg,
                    );
                    final ugaTodayCfr = ugaTodayConfVal > 0
                        ? '${(ugaTodayDeadVal / ugaTodayConfVal * 100).toStringAsFixed(1)}%'
                        : '0.0%';
                    final ugaTodayZones =
                    zonesCount(uganda: true, period: latestPeriodUg).toString();

                    final latestDateUg      = periodToDate(latestPeriodUg);
                    final latestDateDRC      = periodToDate(latestPeriodDRC);
                    final todayDate       = periodToDate(todayPeriod);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [



                            Container(
                              height: 40,
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: TabBar(
                                controller: _tabController,
                                onTap: (index) {
                                  setState(() {});
                                },
                                indicator: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF4A90E2),
                                      Color(0xFF2C469A),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                dividerColor: Colors.transparent,
                                labelColor: Colors.white,
                                unselectedLabelColor: const Color(0xFF6B7280),
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                ),
                                tabs: tabs.map((e) => Tab(child: Container(
                                  padding: const EdgeInsets.symmetric(vertical:  5,horizontal: 10),
                                  child: Text(e),
                                ),)).toList(),
                              ),
                            ),

                            const SizedBox(height: 16),


                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          child: Container(
                            key: ValueKey(_tabController.index),
                            child: _tabController.index==0?Column(
                              children: [
                                _countrySection(
                                  country: "Democratic Republic of the Congo (DRC)",
                                  date: latestDateDRC,
                                  cards: [
                                    // _statData(
                                    //   value: drcCumulSuspected,
                                    //   label: "SUSPECTED\nCASES",
                                    //   color: const Color(0xff747b8d),
                                    // ),
                                    _statData(
                                      value: fmt(drcCumulConfirmed),
                                      label: "CONFIRMED\nCASES",
                                      color: const Color(0xff39b5e8),
                                    ),
                                    // _statData(
                                    //   value: drcCumulSuspDead,
                                    //   label: "SUSPECTED\nDEATHS",
                                    //   color: const Color(0xffff770f),
                                    // ),
                                    _statData(
                                      value: fmt(drcCumulConfDead),
                                      label: "CONFIRMED\nDEATHS",
                                      color: const Color(0xff971b1b),
                                    ),
                                    _statData(
                                      value: drcCumulCfr,
                                      label: "% CFR",
                                      color: const Color(0xfff5a142),
                                    ),
                                    _statData(
                                      value: drcHealthZones,
                                      label: "AFFECTED\nZONES",
                                      color: const Color(0xff08152f),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 20),

                                _countrySection(
                                  country: "Uganda",
                                  date: latestDateUg,
                                  cards: [
                                    // _statData(
                                    //   value: ugaCumulSuspected,
                                    //   label: "SUSPECTED\nCASES",
                                    //   color: const Color(0xff747b8d),
                                    // ),
                                    _statData(
                                      value: fmt(ugaCumulConfirmed),
                                      label: "CONFIRMED\nCASES",
                                      color: const Color(0xff39b5e8),
                                    ),
                                    // _statData(
                                    //   value: ugaCumulSuspDead,
                                    //   label: "SUSPECTED\nDEATHS",
                                    //   color: const Color(0xffff770f),
                                    // ),
                                    _statData(
                                      value: fmt(ugaCumulConfDead),
                                      label: "CONFIRMED\nDEATHS",
                                      color: const Color(0xff971b1b),
                                    ),
                                    _statData(
                                      value: ugaCumulCfr,
                                      label: "% CFR",
                                      color: const Color(0xfff5a142),
                                    ),
                                    _statData(
                                      value: ugaDistricts,
                                      label: "AFFECTED\nDISTRICTS",
                                      color: const Color(0xff08152f),
                                    ),
                                  ],
                                ),
                              ],
                            ):Column(
                              children: [
                                _countrySection(
                                  isNew: true,
                                  country: "Democratic Republic of the Congo (DRC)",
                                  date: latestDateDRC,
                                  cards: [
                                    _statData(
                                      value: drcTodaySuspected,
                                      label: "SUSPECTED\nCASES",
                                      color: const Color(0xff747b8d),
                                    ),
                                    _statData(
                                      value: drcTodayConfirmed,
                                      label: "CONFIRMED\nCASES",
                                      color: const Color(0xff39b5e8),
                                    ),
                                    _statData(
                                      value: drcTodaySuspDead,
                                      label: "SUSPECTED\nDEATHS",
                                      color: const Color(0xffff770f),
                                    ),
                                    _statData(
                                      value: drcTodayConfDead,
                                      label: "CONFIRMED\nDEATHS",
                                      color: const Color(0xff971b1b),
                                    ),
                                    // _statData(
                                    //   value: drcTodayCfr,
                                    //   label: "% CFR",
                                    //   color: const Color(0xfff5a142),
                                    // ),
                                    // _statData(
                                    //   value: drcTodayZones,
                                    //   label: "HEALTH ZONES\nAFFECTED",
                                    //   color: const Color(0xff08152f),
                                    // ),
                                  ],
                                ),

                                const SizedBox(height: 20),

                                _countrySection(
                                  isNew: true,
                                  country: "Uganda",
                                  date: latestDateUg,
                                  cards: [
                                    _statData(
                                      value: ugaTodaySuspected,
                                      label: "SUSPECTED\nCASES",
                                      color: const Color(0xff747b8d),
                                    ),
                                    _statData(
                                      value: ugaTodayConfirmed,
                                      label: "CONFIRMED\nCASES",
                                      color: const Color(0xff39b5e8),
                                    ),
                                    _statData(
                                      value: ugaTodaySuspDead,
                                      label: "SUSPECTED\nDEATHS",
                                      color: const Color(0xffff770f),
                                    ),
                                    _statData(
                                      value: ugaTodayConfDead,
                                      label: "CONFIRMED\nDEATHS",
                                      color: const Color(0xff971b1b),
                                    ),
                                    // _statData(
                                    //   value: ugaTodayCfr,
                                    //   label: "% CFR",
                                    //   color: const Color(0xfff5a142),
                                    // ),
                                    // _statData(
                                    //   value: ugaTodayZones,
                                    //   label: "DISTRICTS\nAFFECTED",
                                    //   color: const Color(0xff08152f),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // LEFT PANEL

                        // _dashboardCard(
                        //   title: "CUMULATIVE CASES",
                        //   child:
                        // ),

                        // const SizedBox(height: 20),
                        // _tabController.index==1?:Offstage()
                        // _dashboardCard(
                        //   title: "NEW CASES TODAY",
                        //   child:
                        // ),
                        // RIGHT PANEL

                      ],
                    );}
                  return SizedBox();
                }
            ),
            SizedBox(height: 15,),
            OutbreakOverviewPage()
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String title,
    required String hint,
    required IconData suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   title,
        //   style: const TextStyle(
        //     fontWeight: FontWeight.w700,
        //   ),
        // ),
        // const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.blueGrey.shade100,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  hint,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              Icon(suffixIcon,size: 15,color: Colors.grey.shade700,),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dashboardCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xff35afe6),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _countrySection({
    required String country,
    required String date,
    required List<Widget> cards,
    bool isNew = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Colors.black,
            ),
            children: [
              // const TextSpan(text: "In the ",style:  TextStyle(fontSize: 10)),
              TextSpan(
                text: country,
                style: const TextStyle(fontSize: 11,fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ", as of $date",style: const TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ThreeItemGrid(
          itemCount: cards.length,
          isNew: isNew,
          itemBuilder: (context, index) {
            return cards[index];
          },
        ),
        // Wrap(
        //   spacing: 12,
        //   runSpacing: 12,
        //   children: cards,
        // ),
      ],
    );
  }


  Widget _statData({
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // const SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 7


                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class AnalyticsRow {
  final String dx;
  final String pe;
  final String ou;
  final double value;

  AnalyticsRow({
    required this.dx,
    required this.pe,
    required this.ou,
    required this.value,
  });

  factory AnalyticsRow.fromList(List<dynamic> row) {
    return AnalyticsRow(
      dx: row[0].toString(),
      pe: row[1].toString(),
      ou: row[2].toString(),
      value: double.tryParse(row[3].toString()) ?? 0,
    );
  }
}


class ThreeItemGrid extends StatelessWidget {
  final int itemCount;
  final bool isNew;
  final Widget Function(BuildContext context, int index) itemBuilder;

  const ThreeItemGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.isNew = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columns = isNew?4:4;
        const spacing =10.0;

        final itemWidth =
            (constraints.maxWidth - (spacing * (columns - 1))) / columns;

        return GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: itemCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: isNew?20: spacing,
            mainAxisSpacing: isNew?40:spacing,
            childAspectRatio: 1.5,
          ),
          itemBuilder: itemBuilder,
        );
      },
    );
  }
}
