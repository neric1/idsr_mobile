import 'package:flutter/material.dart';

class SimpleWeekPicker extends StatefulWidget {
  final ValueChanged<WeekRange> onChanged;

  const SimpleWeekPicker({super.key, required this.onChanged});

  @override
  State<SimpleWeekPicker> createState() => _SimpleWeekPickerState();
}

class _SimpleWeekPickerState extends State<SimpleWeekPicker> {
  late WeekRange selectedWeek;

  @override
  void initState() {
    super.initState();
    selectedWeek = weekFromDate(DateTime.now());
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedWeek.start,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      final week = weekFromDate(picked);
      setState(() => selectedWeek = week);
      widget.onChanged(week);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pickDate,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_today, size: 16),
            const SizedBox(width: 8),
            Text(selectedWeek.label),
          ],
        ),
      ),
    );
  }
}
class WeekRange {
  final DateTime start;
  final DateTime end;

  WeekRange(this.start, this.end);

  String get label =>
      '${_fmt(start)} - ${_fmt(end)}';

  static String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/'
          '${d.month.toString().padLeft(2, '0')}/'
          '${d.year}';
}

WeekRange weekFromDate(DateTime date) {
  final monday = date.subtract(Duration(days: date.weekday - 1));
  final sunday = monday.add(const Duration(days: 6));
  return WeekRange(monday, sunday);
}
