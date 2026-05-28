import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/user/user_bloc.dart';
import 'package:idsr/application/user/user_event.dart';
import 'package:idsr/application/user/user_state.dart';
import 'package:idsr/presentation/settings/about.dart';
import 'package:idsr/session_hive.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFececec),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context,state) {
          return Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: aboutButton(context),
              // ),
            Session.isLoggedIn || state is! Loggedout?  Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                    width: double.infinity, // Fills full screen width
                    child: ElevatedButton(
                      onPressed: (){
                      context.read<UserBloc>().add(LogoutEvent());

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Center content
                        children: const [
                          Icon(Icons.power_settings_new, size: 28),
                          SizedBox(width: 12),
                          Text(
                            "Logout",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
              )):Offstage(),
            ],

          );
        }
      )
    );
  }
}
Widget aboutButton(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const AboutPage(),
        ),
      );
    },
    borderRadius: BorderRadius.circular(14),
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: const Offset(0, 2),
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline,
            size: 24,
            color: Colors.blue,
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  "About",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "WHO AFRO collaboration",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
        ],
      ),
    ),
  );
}