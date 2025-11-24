import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class GradeDetails extends StatelessWidget {
  const GradeDetails({super.key});

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
            "Recent Events",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      )
      ,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 20),

              Event(
                disease: "Mpox",
                country: "Tanzania",
                countryCode: "TZ",
                description:
                "On 10 March 2025, the Ministry of Health of Tanzania notified WHO of two laboratory-confirmed cases...",
              ),

              Event(
                disease: "Cholera",
                country: "Namibia",
                countryCode: "NA",
                description:
                "On 11 March 2025, Namibia's Ministry of Health declared a cholera outbreak after laboratory confirmation...",
              ),

              Event(
                disease: "Mpox",
                country: "South Africa",
                countryCode: "ZA",
                description:
                "On 24 February 2025, the Government of South Africa notified WHO of a new cluster...",
              ),

              Event(
                disease: "Cholera",
                country: "Kenya",
                countryCode:"KE",
                description:
                "There is an ongoing cholera outbreak in Kenya affecting Migori county since 10 February 2025...",
              ),

              // etc...
            ],
          ),
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
                countryCode,
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
