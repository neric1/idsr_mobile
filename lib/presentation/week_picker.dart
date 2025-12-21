import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

class WeekPickerPopup extends StatefulWidget {
  final DateTime initialDate;
  // final ValueChanged<,DateTime> onSelected;
  final void Function(DateTimeRange range, DateTime selectedDate) onSelected;

  const WeekPickerPopup({
    Key? key,
    required this.initialDate,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<WeekPickerPopup> createState() => _WeekPickerPopupState();
}

class _WeekPickerPopupState extends State<WeekPickerPopup> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  DateTimeRange _getWeekRange(DateTime date) {
    final j = Jiffy.parseFromDateTime(date);
    DateTime startOfWeek = j.startOf(Unit.week).dateTime;
    DateTime endOfWeek = j.endOf(Unit.week).dateTime;
    return DateTimeRange(start: startOfWeek, end: endOfWeek);
  }
  @override
  Widget build(BuildContext context) {
    // final weekRange = _getWeekRange(_selectedDate);

    return AlertDialog(
      title: Text('Select Week'),
      content: SizedBox(
        width: 300,
        child:  ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: WeeklyDatePicker(
            selectedDay: _selectedDate,
            changeDay: (value) => setState(() {
              _selectedDate = value;
            }),
            enableWeeknumberText: true,
            weeknumberColor: const Color(0xFF57AF87),
            weeknumberTextColor: Colors.white,
            backgroundColor: const Color(0xFF1A237E),
            weekdayTextColor: const Color(0xFF8A8A8A),
            digitsColor: Colors.white,
            selectedDigitBackgroundColor: const Color(0xFF57AF87),
            weekdays: const ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"],
            daysInWeek: 7,

          ),
        ),



      ),
      actions: [
        TextButton(
          onPressed: () {
            final range = _getWeekRange(_selectedDate);
            widget.onSelected(range,_selectedDate);
            Navigator.pop(context);
          },
          child: const Text('Select'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
