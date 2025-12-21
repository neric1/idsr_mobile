
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:idsr/presentation/event_details.dart';
import 'package:idsr/presentation/grade_details.dart';
import 'package:idsr/presentation/home_page.dart';
import 'package:idsr/presentation/signals_details.dart';
import 'package:idsr/presentation/splash_screen.dart';
import 'package:idsr/presentation/who_afro_dashboard.dart';
import 'package:idsr/routes/routes_name.dart';

class Routes {
  late final go = GoRouter(
      routes: [
      GoRoute(
      name: SPLASH_ROUTE,
      path: SPLASH_ROUTE,
      builder: (context, state) {
        return  SplashScreen();}
      ),
        GoRoute(
        name: HOME_ROUTE,
        path: HOME_ROUTE,

        builder: (context, state) {

        return  WhoAfrDashboard();}
        ),
        GoRoute(
            name: GRADE_DETAILS,
            path: GRADE_DETAILS,

            builder: (context, state) {
              final grades = (state.extra
              as Map<String, dynamic>?)?["grade_list"];
              final title = (state.extra
              as Map<String, dynamic>?)?["grade_name"];
              return  GradeDetails(grades: grades,title: title,);}
        ),
        GoRoute(
            name: EVENT_DETAILS,
            path: EVENT_DETAILS,

            builder: (context, state) {
              final grades = (state.extra
              as Map<String, dynamic>?)?["event_list"];
              final title = (state.extra
              as Map<String, dynamic>?)?["event_name"];
              return  EventDetails(trackedEntities: grades,title: title,);}
        ),
        GoRoute(
            name: SIGNAL_DETAILS,
            path: SIGNAL_DETAILS,

            builder: (context, state) {
              final entity = (state.extra
              as Map<String, dynamic>?)?["entity"];
              final type = (state.extra
              as Map<String, dynamic>?)?["type"];
              return  SignalsDetails(trackedEntity: entity,type: type,);}
        ),
  ]);}