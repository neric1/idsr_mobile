import 'package:flutter/material.dart';

class MapLegend extends StatelessWidget {
   MapLegend({super.key});

  final List<Map<String, dynamic>> legendItems =  [

    {'color': Colors.yellow.shade200, 'label': '1-3 Events'},
    {'color': Colors.orange.shade300, 'label': '3-6 Events'},
    {'color':  Colors.orange.shade900, 'label': '6-9 Events'},
    {'color': Colors.red.shade900, 'label': '9+ Events'},
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
            'Ongoing Events',
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
