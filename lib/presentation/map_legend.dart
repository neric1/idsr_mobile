import 'package:flutter/material.dart';

class MapLegend extends StatelessWidget {
  const MapLegend({super.key});

  final List<Map<String, dynamic>> legendItems = const [
    {'color': Color(0xFFFFF3E0), 'label': '0-2 Events'},
    {'color': Color(0xFFFFCC80), 'label': '2-4 Events'},
    {'color': Color(0xFFD79B60), 'label': '4-6 Events'},
    {'color': Color(0xFFFFF9C4), 'label': '6-8 Events'},
    {'color': Color(0xFFFFC107), 'label': '8-10 Events'},
    {'color': Color(0xFFD9534F), 'label': '10+ Events'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Number of Events',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          ),
          const SizedBox(height: 3),
          ...legendItems.map((item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: item['color'],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black12, width: 0.5),
                  ),
                ),
                const SizedBox(width: 5),
                Text(item['label'],style: const TextStyle(fontSize: 8),)
              ],
            ),
          )),
        ],
      ),
    );
  }
}
