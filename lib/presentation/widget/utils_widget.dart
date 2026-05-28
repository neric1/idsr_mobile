import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget sourceLink(){
  return Padding(
    padding: const EdgeInsets.symmetric( horizontal: 18.0),
    child: Row(
      children: [
        Text(
          "Source: WHO Africa",
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(width: 5,),
        InkWell(
          onTap: () async {
            // print("object==");
           await launchUrl(Uri.parse("https://idsr.afro.who.int"),mode: LaunchMode.externalApplication);
          },
          child: Text(
            "https://idsr.afro.who.int",
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    ),
  );
}