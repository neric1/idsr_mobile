import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class GradeDetails extends StatelessWidget {

  final String title;
  final Map<String, dynamic> grades;
  const GradeDetails({super.key,required this.title,required this.grades});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),   // or context.pop();
        ),
        title:  Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      )
      ,
      body: SafeArea(
        child: ListView.builder(
          itemCount: grades["events"].length,
          itemBuilder: (context, index) {

            return Event(disease: "${grades["events"][index]}",
              country: "",
              countryCode: "",
              description:
              "On 11 March 2025, Namibia's Ministry of Health declared a cholera outbreak after laboratory confirmation...",
            );
            //   ListTile(
            //   leading: CircleAvatar(child: Text('${index + 1}')),
            //   title: Text("${grades["events"][index]}"),
            //   subtitle: Text('Subtitle for '),
            //   trailing: Icon(Icons.arrow_forward_ios),
            //   onTap: () {
            //     print('Tapped on');
            //   },
            // );
          },
        ),
      ),
      );

  }
}

class Event extends StatelessWidget {
  final String disease;
  final String country;
  final String countryCode;   // ← Use ISO country code (TZ, KE, ZA…)
  final String description;

  const Event({
    super.key,
    required this.disease,
    required this.country,
    required this.countryCode,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // Disease name
        Text(
          disease,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),

        // Flag + country name + yellow badge
        Row(
          children: [
            SizedBox(
              height: 20,
              width: 28,
              child: CountryFlag.fromCountryCode(
                "RW",
                // width: 28,
                // height: 20,
              ),
            ),

            const SizedBox(width: 8),

            Text(
              country,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(width: 6),

            Container(
              width: 24,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.yellow.shade600,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),

        // Description with ellipsis
        Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),

        const SizedBox(height: 12),
        Divider(color: Colors.grey.shade300),
        const SizedBox(height: 12),
      ],
    );
  }
}
