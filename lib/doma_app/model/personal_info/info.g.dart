// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalInfo _$PersonalInfoFromJson(Map<String, dynamic> json) => PersonalInfo(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      active: json['active'] as bool?,
      roles: (json['roles'] as List<dynamic>)
          .map((e) => Roles.fromJson(e as Map<String, dynamic>))
          .toList(),
      isolatePermissions: (json['isolatePermissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PersonalInfoToJson(PersonalInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'active': instance.active,
      'roles': instance.roles.map((e) => e.toJson()).toList(),
      'isolatePermissions': instance.isolatePermissions,
    };

Roles _$RolesFromJson(Map<String, dynamic> json) => Roles(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      active: json['active'] as bool,
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => Permissions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RolesToJson(Roles instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'active': instance.active,
      'permissions': instance.permissions.map((e) => e.toJson()).toList(),
    };

Permissions _$PermissionsFromJson(Map<String, dynamic> json) => Permissions(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$PermissionsToJson(Permissions instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
