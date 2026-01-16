import 'package:flutter/material.dart';

class MapSignalLegend extends StatelessWidget {
  MapSignalLegend({super.key});

  final List<Map<String, dynamic>> legendItems =  [
    {'color': Color(0xFF248f24), 'label': '0 Signal'},
    {'color': Colors.yellow.shade200, 'label': '1-30 Signals'},
    {'color': Colors.orange.shade300, 'label': '30-60 Signals'},
    {'color':  Colors.orange.shade900, 'label': '60-90 Signals'},
    {'color': Colors.red.shade900, 'label': '90+ Signals'},
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
            'Signals',
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
                    color: item['color'].withOpacity(0.6),
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
