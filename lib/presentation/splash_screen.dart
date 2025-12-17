
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
            ..add(GetTrackedEntityEvent(programeId: 'bG3Arfj8AtF')),
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
              child: Stack(
                children: [
                  Image.asset('assets/logo2.png',height: 200,width: 200,fit: BoxFit.contain,),
                  Positioned(
                    bottom: 0, // distance from bottom
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        "SEMS",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2c6693),
                          letterSpacing: 1.2,
                        ),
                      ),
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