
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:idsr/presentation/home_page.dart';
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

  ]);}