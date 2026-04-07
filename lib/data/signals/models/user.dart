class User {
  final String id;
  final String username;
  final String surname;
  final String firstName;
  final DateTime created;
  final DateTime lastUpdated;

  final List<IdModel> dataViewOrganisationUnits;
  final List<dynamic> favorites;
  final Sharing sharing;

  final List<dynamic> userGroupAccesses;
  final List<dynamic> userAccesses;
  final List<IdModel> userGroups;

  final List<dynamic> translations;
  final List<IdModel> teiSearchOrganisationUnits;
  final List<IdModel> organisationUnits;

  final bool externalAccess;
  final String displayName;
  final Access access;
  final String name;
  final String email;
  final String phoneNumber;

  final List<IdModel> userRoles;
  final Settings settings;

  final List<String> programs;
  final List<String> authorities;
  final List<String> dataSets;

  final UserCredentials userCredentials;

  User({
    this.id = '',
    this.username = '',
    this.surname = '',
    this.firstName = '',
    DateTime? created,
    DateTime? lastUpdated,
    this.dataViewOrganisationUnits = const [],
    this.favorites = const [],
    Sharing? sharing,
    this.userGroupAccesses = const [],
    this.userAccesses = const [],
    this.userGroups = const [],
    this.translations = const [],
    this.teiSearchOrganisationUnits = const [],
    this.organisationUnits = const [],
    this.externalAccess = false,
    this.displayName = '',
    Access? access,
    this.name = '',
    this.email = '',
    this.phoneNumber = '',
    this.userRoles = const [],
    Settings? settings,
    this.programs = const [],
    this.authorities = const [],
    this.dataSets = const [],
    UserCredentials? userCredentials,
  })  : created = created ?? DateTime.now(),
        lastUpdated = lastUpdated ?? DateTime.now(),
        sharing = sharing ?? Sharing(),
        access = access ?? Access(),
        settings = settings ?? Settings(),
        userCredentials = userCredentials ?? UserCredentials();

  factory User.fromJson(Map<String, dynamic>? json) {
    if (json == null) return User();

    return User(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      surname: json['surname'] ?? '',
      firstName: json['firstName'] ?? '',
      created: DateTime.tryParse(json['created'] ?? '') ?? DateTime.now(),
      lastUpdated: DateTime.tryParse(json['lastUpdated'] ?? '') ?? DateTime.now(),

      dataViewOrganisationUnits: (json['dataViewOrganisationUnits'] as List? ?? [])
          .map((e) => IdModel.fromJson(e))
          .toList(),

      favorites: json['favorites'] ?? [],

      sharing: Sharing.fromJson(json['sharing']),

      userGroupAccesses: json['userGroupAccesses'] ?? [],
      userAccesses: json['userAccesses'] ?? [],

      userGroups: (json['userGroups'] as List? ?? [])
          .map((e) => IdModel.fromJson(e))
          .toList(),

      translations: json['translations'] ?? [],

      teiSearchOrganisationUnits: (json['teiSearchOrganisationUnits'] as List? ?? [])
          .map((e) => IdModel.fromJson(e))
          .toList(),

      organisationUnits: (json['organisationUnits'] as List? ?? [])
          .map((e) => IdModel.fromJson(e))
          .toList(),

      externalAccess: json['externalAccess'] ?? false,
      displayName: json['displayName'] ?? '',
      access: Access.fromJson(json['access']),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',

      userRoles: (json['userRoles'] as List? ?? [])
          .map((e) => IdModel.fromJson(e))
          .toList(),

      settings: Settings.fromJson(json['settings']),

      programs: List<String>.from(json['programs'] ?? []),
      authorities: List<String>.from(json['authorities'] ?? []),
      dataSets: List<String>.from(json['dataSets'] ?? []),

      userCredentials: UserCredentials.fromJson(json['userCredentials']),
    );
  }
}
class IdModel {
  final String id;

  IdModel({this.id = ''});

  factory IdModel.fromJson(Map<String, dynamic>? json) {
    return IdModel(
      id: json?['id'] ?? '',
    );
  }
}
class Sharing {
  final bool external;
  final Map<String, dynamic> users;
  final Map<String, dynamic> userGroups;

  Sharing({
    this.external = false,
    this.users = const {},
    this.userGroups = const {},
  });

  factory Sharing.fromJson(Map<String, dynamic>? json) {
    return Sharing(
      external: json?['external'] ?? false,
      users: json?['users'] ?? {},
      userGroups: json?['userGroups'] ?? {},
    );
  }
}
class Access {
  final bool manage;
  final bool externalize;
  final bool write;
  final bool read;
  final bool update;
  final bool delete;

  Access({
    this.manage = false,
    this.externalize = false,
    this.write = false,
    this.read = false,
    this.update = false,
    this.delete = false,
  });

  factory Access.fromJson(Map<String, dynamic>? json) {
    return Access(
      manage: json?['manage'] ?? false,
      externalize: json?['externalize'] ?? false,
      write: json?['write'] ?? false,
      read: json?['read'] ?? false,
      update: json?['update'] ?? false,
      delete: json?['delete'] ?? false,
    );
  }
}class Settings {
  final bool keyMessageSmsNotification;
  final String keyStyle;
  final String keyUiLocale;
  final String keyAnalysisDisplayProperty;
  final bool keyMessageEmailNotification;

  Settings({
    this.keyMessageSmsNotification = false,
    this.keyStyle = '',
    this.keyUiLocale = '',
    this.keyAnalysisDisplayProperty = '',
    this.keyMessageEmailNotification = false,
  });

  factory Settings.fromJson(Map<String, dynamic>? json) {
    return Settings(
      keyMessageSmsNotification: json?['keyMessageSmsNotification'] ?? false,
      keyStyle: json?['keyStyle'] ?? '',
      keyUiLocale: json?['keyUiLocale'] ?? '',
      keyAnalysisDisplayProperty: json?['keyAnalysisDisplayProperty'] ?? '',
      keyMessageEmailNotification: json?['keyMessageEmailNotification'] ?? false,
    );
  }
}class UserCredentials {
  final String id;
  final String username;
  final bool externalAuth;
  final bool twoFA;
  final DateTime passwordLastUpdated;
  final DateTime lastLogin;
  final bool selfRegistered;
  final bool invitation;
  final bool disabled;

  final Access access;
  final Sharing sharing;
  final List<IdModel> userRoles;

  UserCredentials({
    this.id = '',
    this.username = '',
    this.externalAuth = false,
    this.twoFA = false,
    DateTime? passwordLastUpdated,
    DateTime? lastLogin,
    this.selfRegistered = false,
    this.invitation = false,
    this.disabled = false,
    Access? access,
    Sharing? sharing,
    this.userRoles = const [],
  })  : passwordLastUpdated = passwordLastUpdated ?? DateTime.now(),
        lastLogin = lastLogin ?? DateTime.now(),
        access = access ?? Access(),
        sharing = sharing ?? Sharing();

  factory UserCredentials.fromJson(Map<String, dynamic>? json) {
    return UserCredentials(
      id: json?['id'] ?? '',
      username: json?['username'] ?? '',
      externalAuth: json?['externalAuth'] ?? false,
      twoFA: json?['twoFA'] ?? false,
      passwordLastUpdated:
      DateTime.tryParse(json?['passwordLastUpdated'] ?? '') ?? DateTime.now(),
      lastLogin:
      DateTime.tryParse(json?['lastLogin'] ?? '') ?? DateTime.now(),
      selfRegistered: json?['selfRegistered'] ?? false,
      invitation: json?['invitation'] ?? false,
      disabled: json?['disabled'] ?? false,
      access: Access.fromJson(json?['access']),
      sharing: Sharing.fromJson(json?['sharing']),
      userRoles: (json?['userRoles'] as List? ?? [])
          .map((e) => IdModel.fromJson(e))
          .toList(),
    );
  }
}