import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class TimelineCard extends StatelessWidget {

  final String? valuemoh;
  final String? valuewco;
  final String? valuemafro;
  final String? valuestart;
  final String? valueend;
  const TimelineCard({super.key,
    this.valuemoh,
    this.valuewco,
    this.valuemafro,
    this.valuestart,
    this.valueend

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      // padding: const EdgeInsets.all(16),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(16),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black.withOpacity(0.05),
      //       blurRadius: 10,
      //       offset: const Offset(0, 4),
      //     )
      //   ],
      // ),
      child: Column(
        children:  [
          TimelineItem(
            title: "Detected by MoH",
            date: valuemoh??"",
            dotColor: Colors.green,
            isFirst: true,
          ),
          TimelineItem(
            title: "Notified to WCO",
            date: valuewco??"",
            dotColor: Colors.green,
          ),
          TimelineItem(
            title: "Notified to AFRO",
            date: valuemafro??"",
            dotColor: Colors.green,
          ),
          TimelineItem(
            title: "Reporting Period Started",
            date: valuestart??"",
            dotColor: Colors.blue,
          ),
          TimelineItem(
            title: "Reporting Period Ended",
            date: valueend??"",
            dotColor: Colors.red,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class TimelineItem extends StatelessWidget {
  final String title;
  final String date;
  final Color dotColor;
  final bool isFirst;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.title,
    required this.date,
    required this.dotColor,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LEFT TIMELINE
          Column(
            children: [
              /// Top line
              if (!isFirst)
                Container(
                  width: 2,
                  height: 20,
                  color: Colors.blue.shade200,
                ),

              /// Dot
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),

              /// Bottom line
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.blue.shade200,
                  ),
                ),
            ],
          ),

          const SizedBox(width: 16),

          /// RIGHT CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        formatDate(date),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  String formatDate(String? date) {
    if (date == null || date.isEmpty) return "-";

    try {
      return Jiffy.parse(date).format(pattern: "dd MMM yyyy");
    } catch (e) {
      return "-";
    }
  }

}
