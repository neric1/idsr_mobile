class TrackedEntity {
  String created;
  String orgUnit;
  String createdAtClient;
  String trackedEntityInstance;
  String lastUpdated;
  String trackedEntityType;
  String lastUpdatedAtClient;
  bool potentialDuplicate;
  bool inactive;
  bool deleted;
  String featureType;
  List<ProgramOwner> programOwners;
  List<Enrollment> enrollments;
  List<dynamic> relationships;
  List<TeiAttribute> attributes;

  TrackedEntity({
    this.created = "",
    this.orgUnit = "",
    this.createdAtClient = "",
    this.trackedEntityInstance = "",
    this.lastUpdated = "",
    this.trackedEntityType = "",
    this.lastUpdatedAtClient = "",
    this.potentialDuplicate = false,
    this.inactive = false,
    this.deleted = false,
    this.featureType = "",
    this.programOwners = const [],
    this.enrollments = const [],
    this.relationships = const [],
    this.attributes = const [],
  });

  factory TrackedEntity.fromJson(Map<String, dynamic> json) {
    return TrackedEntity(
      created: json["created"] ?? "",
      orgUnit: json["orgUnit"] ?? "",
      createdAtClient: json["createdAtClient"] ?? "",
      trackedEntityInstance: json["trackedEntityInstance"] ?? "",
      lastUpdated: json["lastUpdated"] ?? "",
      trackedEntityType: json["trackedEntityType"] ?? "",
      lastUpdatedAtClient: json["lastUpdatedAtClient"] ?? "",
      potentialDuplicate: json["potentialDuplicate"] ?? false,
      inactive: json["inactive"] ?? false,
      deleted: json["deleted"] ?? false,
      featureType: json["featureType"] ?? "",
      programOwners: (json["programOwners"] as List<dynamic>? ?? [])
          .map((e) => ProgramOwner.fromJson(e))
          .toList(),
      enrollments: (json["enrollments"] as List<dynamic>? ?? [])
          .map((e) => Enrollment.fromJson(e))
          .toList(),
      relationships: json["relationships"] ?? [],
      attributes: (json["attributes"] as List<dynamic>? ?? [])
          .map((e) => TeiAttribute.fromJson(e))
          .toList(),
    );
  }
}
class ProgramOwner {
  String ownerOrgUnit;
  String program;
  String trackedEntityInstance;

  ProgramOwner({
    this.ownerOrgUnit = "",
    this.program = "",
    this.trackedEntityInstance = "",
  });

  factory ProgramOwner.fromJson(Map<String, dynamic> json) {
    return ProgramOwner(
      ownerOrgUnit: json["ownerOrgUnit"] ?? "",
      program: json["program"] ?? "",
      trackedEntityInstance: json["trackedEntityInstance"] ?? "",
    );
  }
}
class Enrollment {
  String storedBy;
  String createdAtClient;
  String program;
  String lastUpdated;
  String created;
  String orgUnit;
  String enrollment;
  String trackedEntityInstance;
  String trackedEntityType;
  String orgUnitName;
  String lastUpdatedAtClient;
  String enrollmentDate;
  bool deleted;
  String incidentDate;
  String status;
  List<dynamic> notes;
  List<dynamic> relationships;
  List<EventItem> events;
  List<dynamic> attributes;

  Enrollment({
    this.storedBy = "",
    this.createdAtClient = "",
    this.program = "",
    this.lastUpdated = "",
    this.created = "",
    this.orgUnit = "",
    this.enrollment = "",
    this.trackedEntityInstance = "",
    this.trackedEntityType = "",
    this.orgUnitName = "",
    this.lastUpdatedAtClient = "",
    this.enrollmentDate = "",
    this.deleted = false,
    this.incidentDate = "",
    this.status = "",
    this.notes = const [],
    this.relationships = const [],
    this.events = const [],
    this.attributes = const [],
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      storedBy: json["storedBy"] ?? "",
      createdAtClient: json["createdAtClient"] ?? "",
      program: json["program"] ?? "",
      lastUpdated: json["lastUpdated"] ?? "",
      created: json["created"] ?? "",
      orgUnit: json["orgUnit"] ?? "",
      enrollment: json["enrollment"] ?? "",
      trackedEntityInstance: json["trackedEntityInstance"] ?? "",
      trackedEntityType: json["trackedEntityType"] ?? "",
      orgUnitName: json["orgUnitName"] ?? "",
      lastUpdatedAtClient: json["lastUpdatedAtClient"] ?? "",
      enrollmentDate: json["enrollmentDate"] ?? "",
      deleted: json["deleted"] ?? false,
      incidentDate: json["incidentDate"] ?? "",
      status: json["status"] ?? "",
      notes: json["notes"] ?? [],
      relationships: json["relationships"] ?? [],
      events: (json["events"] as List<dynamic>? ?? [])
          .map((e) => EventItem.fromJson(e))
          .toList(),
    );
  }
}
class UserInfo {
  String uid;
  String firstName;
  String surname;
  String username;

  UserInfo({
    this.uid = "",
    this.firstName = "",
    this.surname = "",
    this.username = "",
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      uid: json["uid"] ?? "",
      firstName: json["firstName"] ?? "",
      surname: json["surname"] ?? "",
      username: json["username"] ?? "",
    );
  }
}
class DataValue {
  String dataElement;
  String value;

  DataValue({
    this.dataElement = "",
    this.value = "",
  });

  factory DataValue.fromJson(Map<String, dynamic> json) {
    return DataValue(
      dataElement: json["dataElement"] ?? "",
      value: json["value"] ?? "",
    );
  }
}
class TeiAttribute {
  String lastUpdated;
  String storedBy;
  String displayName;
  String created;
  String valueType;
  String attribute;
  String value;

  TeiAttribute({
    this.lastUpdated = "",
    this.storedBy = "",
    this.displayName = "",
    this.created = "",
    this.valueType = "",
    this.attribute = "",
    this.value = "",
  });

  factory TeiAttribute.fromJson(Map<String, dynamic> json) {
    return TeiAttribute(
      lastUpdated: json["lastUpdated"] ?? "",
      storedBy: json["storedBy"] ?? "",
      displayName: json["displayName"] ?? "",
      created: json["created"] ?? "",
      valueType: json["valueType"] ?? "",
      attribute: json["attribute"] ?? "",
      value: json["value"] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "lastUpdated": lastUpdated,
      "storedBy": storedBy,
      "displayName": displayName,
      "created": created,
      "valueType": valueType,
      "attribute": attribute,
      "value": value,
    };
  }
}
class EventItem {
  String storedBy;
  String dueDate;
  String program;
  String event;
  String programStage;
  String orgUnit;
  String enrollment;
  String trackedEntityInstance;
  String enrollmentStatus;
  String status;
  String orgUnitName;
  String eventDate;
  String attributeCategoryOptions;
  String lastUpdated;
  String created;
  bool deleted;
  String attributeOptionCombo;
  UserInfo lastUpdatedByUserInfo;
  UserInfo createdByUserInfo;
  List<DataValue> dataValues;
  List<dynamic> notes;
  List<dynamic> relationships;

  EventItem({
    this.storedBy = "",
    this.dueDate = "",
    this.program = "",
    this.event = "",
    this.programStage = "",
    this.orgUnit = "",
    this.enrollment = "",
    this.trackedEntityInstance = "",
    this.enrollmentStatus = "",
    this.status = "",
    this.orgUnitName = "",
    this.eventDate = "",
    this.attributeCategoryOptions = "",
    this.lastUpdated = "",
    this.created = "",
    this.deleted = false,
    this.attributeOptionCombo = "",
    UserInfo? lastUpdatedByUserInfo,
    UserInfo? createdByUserInfo,
    this.dataValues = const [],
    this.notes = const [],
    this.relationships = const [],
  })  : lastUpdatedByUserInfo =
      lastUpdatedByUserInfo ?? UserInfo(),
        createdByUserInfo = createdByUserInfo ?? UserInfo();

  factory EventItem.fromJson(Map<String, dynamic> json) {
    return EventItem(
      storedBy: json["storedBy"] ?? "",
      dueDate: json["dueDate"] ?? "",
      program: json["program"] ?? "",
      event: json["event"] ?? "",
      programStage: json["programStage"] ?? "",
      orgUnit: json["orgUnit"] ?? "",
      enrollment: json["enrollment"] ?? "",
      trackedEntityInstance: json["trackedEntityInstance"] ?? "",
      enrollmentStatus: json["enrollmentStatus"] ?? "",
      status: json["status"] ?? "",
      orgUnitName: json["orgUnitName"] ?? "",
      eventDate: json["eventDate"] ?? "",
      attributeCategoryOptions: json["attributeCategoryOptions"] ?? "",
      lastUpdated: json["lastUpdated"] ?? "",
      created: json["created"] ?? "",
      deleted: json["deleted"] ?? false,
      attributeOptionCombo: json["attributeOptionCombo"] ?? "",
      lastUpdatedByUserInfo:
      UserInfo.fromJson(json["lastUpdatedByUserInfo"] ?? {}),
      createdByUserInfo:
      UserInfo.fromJson(json["createdByUserInfo"] ?? {}),
      dataValues: (json["dataValues"] as List<dynamic>? ?? [])
          .map((e) => DataValue.fromJson(e))
          .toList(),
      notes: json["notes"] ?? [],
      relationships: json["relationships"] ?? [],
    );
  }
}
