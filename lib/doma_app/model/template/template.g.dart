// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Template_ _$Template_FromJson(Map<String, dynamic> json) => Template_(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      parentId: json['parentId'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedDate: json['updatedDate'] as String?,
      size: json['size'] as int?,
      folders: (json['folders'] as List<dynamic>?)
          ?.map((e) => Folders.fromJson(e as Map<String, dynamic>))
          .toList(),
      templates: (json['templates'] as List<dynamic>?)
          ?.map((e) => Templates.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$Template_ToJson(Template_ instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'parentId': instance.parentId,
      'createdBy': instance.createdBy,
      'updatedDate': instance.updatedDate,
      'size': instance.size,
      'folders': instance.folders?.map((e) => e.toJson()).toList(),
      'templates': instance.templates?.map((e) => e.toJson()).toList(),
    };

Folders _$FoldersFromJson(Map<String, dynamic> json) => Folders(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      parentId: json['parentId'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedDate: json['updatedDate'] as String?,
      size: json['size'] as int,
    );

Map<String, dynamic> _$FoldersToJson(Folders instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'parentId': instance.parentId,
      'createdBy': instance.createdBy,
      'updatedDate': instance.updatedDate,
      'size': instance.size,
    };

Templates _$TemplatesFromJson(Map<String, dynamic> json) => Templates(
      id: json['id'] as String?,
      name: json['name'] as String,
      folderId: json['folderId'] as String?,
      createdBy: json['createdBy'] as String?,
      size: json['size'] as int,
    );

Map<String, dynamic> _$TemplatesToJson(Templates instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'folderId': instance.folderId,
      'createdBy': instance.createdBy,
      'size': instance.size,
    };
