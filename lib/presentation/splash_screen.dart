
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idsr/application/entity/entity_bloc.dart';
import 'package:idsr/application/entity/entity_event.dart';
import 'package:idsr/application/entity/entity_state.dart';
import 'package:idsr/application/entity/events/comments_bloc.dart';
import 'package:idsr/application/entity/events/comments_event.dart';
import 'package:idsr/application/signals/signal_bloc.dart';
import 'package:idsr/application/signals/signal_event.dart';
import 'package:idsr/application/signals/signal_state.dart';
import 'package:idsr/routes/routes_name.dart';
import 'package:idsr/session_hive.dart';
class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ValueNotifier<bool> showButtonNotifier = ValueNotifier(false);
  Color bgColor = Color(0xFF082A66);
  Color primaryBlue = Color(0xFF18A7FF);
  Color cyan = Color(0xFF22D3EE);
  Color cardBg = Color(0xFF12377C);
  Color borderColor = Color(0x26FFFFFF);
  Color white70 = Color(0xB3FFFFFF);
  bool tokenExist=false;

  @override
  void initState() {
    super.initState();
    if(mounted){
      context.read<CommentBloc>().add(FetchComments());
    }
    if(mounted && Session.isLoggedIn){
      context.read<SignalBloc>().add(GetTrackedSignalEvent(programeId: 'E12ZY36aT08&attribute=Zhmz8B6mqEx:GE:2017-01-07:LE:null'));}
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF03265e),
      body: SafeArea(
        child: BlocListener<EntityBloc, EntityState>(
          bloc: context.read<EntityBloc>()
            ..add(GetTrackedEntityEvent(programeId: 'bG3Arfj8AtF&attribute=IXtYxqMzT6W:GE:1999-12-25:LE:null')),
          listener: (context, preState) async {
            if(preState is GetTrackedEntityCompleted ){
              try {

                _navigateToProperPage(context);

              } catch (e) {
                // context.read<AuthBloc>().add(LogoutEvent());
              }
            }
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: SvgPicture.asset(
                  'assets/logo.svg',

                  height: 100,
                  fit: BoxFit.contain,
                  colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                ),
              ),
              Expanded(
                child: Center(

                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   textAlign: TextAlign.center,
                        //   "Signals and Events Monitoring",
                        //   style:GoogleFonts.raleway(
                        //     fontSize: 48,
                        //     fontWeight: FontWeight.w200,
                        //     color: Colors.white,
                        //   ),
                        // ),

                        Text(
                          'SEMS',
                          style:  TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 70,
                            fontWeight: FontWeight.w800,
                            height: 0.95,
                            letterSpacing: -1.5,
                          ),
                        ),
                        const SizedBox(height: 14),

                        Text(
                          'Signals, Events outbreaks\nmonitoring and Analytics.',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          width: 72,
                          height: 3,
                          decoration: BoxDecoration(
                            color: cyan.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),

                        const SizedBox(height: 10),
                        SizedBox(
                          width: 290,
                          child: Text(
                            'Integrated intelligence for early detection, rapid response, and better health outcomes.',
                            style: TextStyle(
                              color: white70,
                              fontSize: 17,
                              height: 1.55,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Spacer(),
                        IntrinsicHeight(
                          child: Row(
                            children:  [
                              Expanded(
                                child: _FeatureCard(
                                  icon: Icons.hub_outlined,
                                  iconColor: cyan,
                                  title: 'Signals & Events',
                                  description: 'Detect and monitor\nsignals and events',
                                ),
                              ),
                              SizedBox(width: 14),
                              Expanded(
                                child: _FeatureCard(
                                  icon: Icons.notifications_active_outlined,
                                  iconColor: Color(0xFFFF6B6B),
                                  title: 'Outbreaks',
                                  description: 'Track, assess and\nmanage outbreaks',
                                  badge: true,
                                ),
                              ),
                              SizedBox(width: 14),
                              Expanded(
                                child: _FeatureCard(
                                  icon: Icons.bar_chart_rounded,
                                  iconColor: Color(0xFF27D3B4),
                                  title: 'Analytics',
                                  description: 'Analyze data and\ngenerate insights',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: borderColor),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 46,
                                height: 46,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.white.withValues(alpha: 0.03),
                                ),
                                child:  Icon(
                                  Icons.health_and_safety_outlined,
                                  color: cyan,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Stronger surveillance. Faster response.',
                                      style: GoogleFonts.raleway(
                                        color: Colors.white,
                                        // fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Working together for a healthier Africa.',
                                      style: GoogleFonts.raleway(
                                        color: white70,
                                        // fontSize: 17,
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer()
                        // Stack(
                        //   children: [
                        //     Image.asset('assets/logo2.png',height: 200,width: 200,fit: BoxFit.contain,),
                        //     Positioned(
                        //       bottom: 0, // distance from bottom
                        //       left: 0,
                        //       right: 0,
                        //       child: Center(
                        //         child: Text(
                        //           "SEMS",
                        //           style: TextStyle(
                        //             fontSize: 40,
                        //             fontWeight: FontWeight.w700,
                        //             color: Color(0xFF2c6693),
                        //             letterSpacing: 1.2,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 20,),
                        // Text(
                        //   textAlign: TextAlign.center,
                        //   "Mobile app",
                        //   style:GoogleFonts.raleway(
                        //     fontSize: 48,
                        //     fontWeight: FontWeight.w200,
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
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

  _navigateToProperPage(BuildContext context) {

    final router = GoRouter.of(context);

    Future.delayed(const Duration(seconds: 2), () async {
      if (!mounted) return;
    router.goNamed(HOME_ROUTE);

    });
  }


}
class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final bool badge;

  const _FeatureCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    this.badge = false,
  });

  @override
  Widget build(BuildContext context) {
    const cardBg = Color(0xFF04316a);
    const borderColor = Color(0x26FFFFFF);
    const white70 = Color(0xB3FFFFFF);

    return Container(
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 15),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, color: iconColor, size: 60),
              if (badge)
                Positioned(
                  right: -2,
                  top: -4,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF4D4F),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              color: white70,
              fontSize: 9,
              height: 1.35,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}