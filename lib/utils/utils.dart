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
List<TrackedEntity> filterByDays(
    List<TrackedEntity> list, int days
    ) {
  return list.where((item) {
    final dt = DateTime.parse(item.created);
    return DateTime.now().difference(dt).inHours <= days * 24;
  }).toList();
}

List<TrackedEntity> filterByRecentEvent(
    List<TrackedEntity> list,
    int days,
    ) {
  final now = DateTime.now();

  return list.where((item) {
    final history = item.attributes;
    TeiAttribute?   eventNoteAttribute =history.firstWhereOrNull(
          (attr) => attr.attribute == "IXtYxqMzT6W",
      // orElse: () => null,
    );
    final eventNote=eventNoteAttribute?.value;
    // print(eventNote)

    if(eventNote==null){
      return false;
    }
    // print(eventNote)
    final dt = DateTime.parse(eventNote);
    return DateTime.now().difference(dt).inHours <= days * 24;

  }).toList();
}
