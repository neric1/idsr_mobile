import 'package:flutter/material.dart';

class FilterScreenUI extends StatelessWidget {
  const FilterScreenUI({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title (centered)
            Center(
              child: Text(
                "Filters",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // YEAR
            _label("Year"),
            _roundedDropdown(
              items: ["2025", "2024"],
              selected: "2025",
            ),

            const SizedBox(height: 22),

            // WEEKLINE
            _label("Weekline"),
            _roundedDropdown(
              items: ["2025-49", "2025-48"],
              selected: "2025-49",
            ),

            const SizedBox(height: 22),

            // OUTBREAKS
            _label("Outbreaks"),
            _roundedDropdown(
              items: ["All Outbreaks", "Cholera", "Measles"],
              selected: "All Outbreaks",
            ),

            const SizedBox(height: 22),

            // HUMANITARIAN CRISES
            _label("Humanitarian Crises"),
            _roundedDropdown(
              items: ["All Humanitarian Crises", "Flood", "Drought"],
              selected: "All Humanitarian Crises",
            ),

            const SizedBox(height: 22),

            // GRADE
            _label("Grade"),
            _roundedDropdown(
              items: ["All Grades", "Grade 1", "Grade 2"],
              selected: "All Grades",
            ),
            //
            // const SizedBox(height: 22),
            //
            // // HUB
            // _label("Hub"),
            // _roundedDropdown(
            //   items: ["All Hubs", "East Hub", "West Hub"],
            //   selected: "All Hubs",
            // ),

            const SizedBox(height: 22),

            // COUNTRIES
            _label("Countries"),
            _roundedDropdown(
              items: ["All Countries", "Kenya", "Uganda"],
              selected: "All Countries",
            ),

            const SizedBox(height: 40),
          ],
        ),
    );

  }

  // ---------- LABEL ----------
  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ---------- ROUNDED DROPDOWN ----------
  Widget _roundedDropdown({
    required List<String> items,
    required String selected,
  }) {
    return Container(
      height: 56,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE1E4E8),
          width: 1.3,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selected,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 28,
            color: Colors.black54,
          ),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
          items: items
              .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ))
              .toList(),
          onChanged: (_) {},
        ),
      ),
    );
  }
}
