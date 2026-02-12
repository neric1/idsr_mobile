import 'package:collection/collection.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';

Map<String, dynamic> countByGrades(
    List<TrackedEntity>? statsData,
    String desiredValue, {
      String dataElement = "LqnH4F5WpTi",
    }) {
  // Result containers
  final Set<String> countedEventsSet = {};
  final Map<String, String> ungradedEventsMap = {};
  List<TrackedEntity> gradedEntity=[];

  if (statsData == null || statsData is! List) {
    print("Invalid or empty statsData");
    return {
      "totalCount": 0,
      "events": [],
    };
  }

  for (var instance in statsData) {
    final enrollments = instance.enrollments;
    if (enrollments.isNotEmpty) {
      final latestEnrollment = enrollments.last;

      final orgUnit = latestEnrollment.orgUnit;
      final orgUnitName = latestEnrollment.orgUnitName;

      final events = latestEnrollment.events;
      for (var event in events) {
        final dataValues = event.dataValues;

        // Find grade value

        DataValue? gradeValue = dataValues.firstWhereOrNull(
              (dv) => dv.dataElement == dataElement,
        );


        // Find "Event name" attribute
        final attributes = instance.attributes;



        TeiAttribute?   eventNameAttribute = attributes.firstWhereOrNull(
                (attr) => attr.displayName == "Event name",
            // orElse: () => null,
          );


        final eventName = eventNameAttribute?.value;
        final grade = gradeValue?.value;

        if (eventName != null && grade == desiredValue) {
          final eventKey = eventName;
          final eventCountryKey = "${eventName}_$orgUnit";

          if (desiredValue == "Ungraded") {
            if (!ungradedEventsMap.containsKey(eventCountryKey)) {
              final formattedEvent = "$eventName ($orgUnitName)";
              ungradedEventsMap[eventCountryKey] = formattedEvent;
              gradedEntity.add(instance);

            }
          } else {
            countedEventsSet.add(eventKey);
            gradedEntity.add(instance);

          }
        }
      }
        }
  }

  // Convert to list based on desiredValue
  final countedEvents = desiredValue == "Ungraded"
      ? ungradedEventsMap.values.toList()
      : countedEventsSet.toList();

  return {
    "totalCount": countedEvents.length,
    "events": countedEvents,
    "gradedEntity":gradedEntity
  };
}
List<TrackedEntity> filterSortAndTake(
    List<TrackedEntity> list,
    int days, {
      int? takeCount,
    }) {
  final now = DateTime.now();
  final cutoff = now.subtract(Duration(days: days));

  final filtered = <TrackedEntity>[];

  for (final item in list) {
    try {
      final dt = DateTime.parse(item.created);

      if (dt.isAfter(cutoff) && dt.isBefore(now)) {
        filtered.add(item);
      }
    } catch (_) {}
  }

  filtered.sort((a, b) =>
      DateTime.parse(b.created)
          .compareTo(DateTime.parse(a.created)));

  // If takeCount is null → return all
  return takeCount == null
      ? filtered
      : filtered.take(takeCount).toList();
}

// List<TrackedEntity> filterByRecentEvent(
//     List<TrackedEntity> list,
//     int days,
//     ) {
//   final now = DateTime.now();
//
//   return list.where((item) {
//     final history = item.attributes;
//     TeiAttribute?   eventNoteAttribute =history.firstWhereOrNull(
//           (attr) => attr.attribute == "IXtYxqMzT6W",
//       // orElse: () => null,
//     );
//     final eventNote=eventNoteAttribute?.value;
//     // print(eventNote)
//
//     if(eventNote==null){
//       return false;
//     }
//     // print(eventNote)
//     final dt = DateTime.parse(eventNote);
//     return DateTime.now().difference(dt).inHours <= days * 24;
//
//   }).toList();
// }
List<TrackedEntity> filterByRecentEvent(
    List<TrackedEntity> list,
    int days,
    ) {
  final now = DateTime.now();

  final filtered = list
      .map((item) {
    final attr = item.attributes.firstWhereOrNull(
          (a) => a.attribute == "IXtYxqMzT6W",
    );

    if (attr?.value == null) return null;

    return MapEntry(item, DateTime.parse(attr!.value!));
  })
      .whereType<MapEntry<TrackedEntity, DateTime>>()
      .where((entry) => now.difference(entry.value).inDays <= days)
      .toList();

  // 🔽 sort by most recent first
  filtered.sort((a, b) => b.value.compareTo(a.value));

  // 🔢 take only 5
  return filtered.map((e) => e.key).toList();
}
String getCountryNameOnMap(String countryId, String name) {
  switch (countryId) {
    case "FBp81RH2tMk":
      return "Tanzania";
    case "ovvu8SlYevT":
      return "S. Sudan";
    case "OhZHTN8wn0t":
      return "Côte d'Ivoire";
    case "HZtKIozL115":
      return "Sierra Leone";
    case "ZoH5flTZbXw":
      return "Central African Rep.";
    case "jCQVCvr10mf":
      return "Dem. Rep. Congo";
    case "XhcIn2FWihU":
      return "South Africa";
    case "CHG4FtC04EF":
      return "Burkina Faso";
    case "Vpy7G6Pg0bI":
      return "Eq. Guinea";
    case "DssnVxramcD":
      return "eSwatini";
    default:
      return name;
  }
}
({int year, int week}) getIsoWeek(DateTime date) {
  final thursday =
  date.add(Duration(days: 3 - ((date.weekday + 6) % 7)));

  final isoYear = thursday.year;
  final firstThursday = DateTime(isoYear, 1, 4);

  final week =
      1 + ((thursday.difference(firstThursday).inDays) ~/ 7);

  return (year: isoYear, week: week);
}
