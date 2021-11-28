import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';

@JsonSerializable(explicitToJson: true)
class PersonalInfo {
  String id;
  String email;
  String firstName;
  String lastName;
  String? phoneNumber;
  bool? active;
  List<Roles> roles;
  List<String>? isolatePermissions;

  PersonalInfo(
      {required this.id,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.phoneNumber,
        required this.active,
        required this.roles,
        required this.isolatePermissions});

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => _$PersonalInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Roles {
  String id;
  String name;
  String? description;
  bool active;
  List<Permissions> permissions;

  Roles({required this.id, required this.name, required this.description, required this.active, required this.permissions});

  factory Roles.fromJson(Map<String, dynamic> json) => _$RolesFromJson(json);

  Map<String, dynamic> toJson() => _$RolesToJson(this);
}

@JsonSerializable()
class Permissions {
  String id;
  String name;
  String? description;

  Permissions({required this.id, required this.name, required this.description});

  factory Permissions.fromJson(Map<String, dynamic> json) => _$PermissionsFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionsToJson(this);
}
