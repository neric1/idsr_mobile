import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/user/user_bloc.dart';
import 'package:idsr/application/user/user_event.dart';
import 'package:idsr/application/user/user_state.dart';
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
