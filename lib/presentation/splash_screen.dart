
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:idsr/application/entity/entity_bloc.dart';
import 'package:idsr/application/entity/entity_event.dart';
import 'package:idsr/application/entity/entity_state.dart';
import 'package:idsr/routes/routes_name.dart';
class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ValueNotifier<bool> showButtonNotifier = ValueNotifier(false);

  bool tokenExist=false;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF1A237E),
      body: SafeArea(
        child: BlocListener<EntityBloc, EntityState>(
          bloc: context.read<EntityBloc>()
            ..add(GetTrackedEntityEvent()),
          listener: (context, preState) async {
            if(preState is GetTrackedEntityCompleted ){
              try {

                _navigateToProperPage(context);
      
              } catch (e) {
                // context.read<AuthBloc>().add(LogoutEvent());
              }
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [


                  Text(
                    "SEMS",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
      
      
      
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _navigateToProperPage(BuildContext context) {

    final router = GoRouter.of(context);

    Future.delayed(const Duration(seconds: 2), () async {
      if (!mounted) return;
    router.goNamed(HOME_ROUTE);

    });
  }


}