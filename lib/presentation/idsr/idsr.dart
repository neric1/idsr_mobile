import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/idsr/threshold_bloc.dart';
import 'package:idsr/application/idsr/threshold_event.dart';
import 'package:idsr/presentation/idsr/idsr_dashboard.dart';
import 'package:idsr/utils/constant.dart';
import 'package:idsr/utils/utils.dart';
import 'package:week_of_year/date_week_extensions.dart';

class Idsr extends StatefulWidget {
  const Idsr({super.key});

  @override
  State<Idsr> createState() => _IdsrState();
}

class _IdsrState extends State<Idsr> {
  int isoweek=DateTime.now().weekOfYear;
  DateTime current=DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final w=getPreviousWeek(getPreviousWeek("${current.year}W$isoweek"));
    context.read<ThresholdBloc>()
          .add(LoadThreshold(getOrganizationUnit(), "${getPreviousWeek(w)};$w"));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFececec),
        body: SingleChildScrollView(

          child: Column(
            children: [
              IdsrDashboard(orgunit: getOrganizationUnit(), period: "2026W09;2026W10")
            ],
          ),
        ),
      ),
    );
  }
}
