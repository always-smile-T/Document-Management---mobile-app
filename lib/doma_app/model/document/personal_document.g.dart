// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
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
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => Files.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'parentId': instance.parentId,
      'createdBy': instance.createdBy,
      'updatedDate': instance.updatedDate,
      'size': instance.size,
      'folders': instance.folders?.map((e) => e.toJson()).toList(),
      'files': instance.files?.map((e) => e.toJson()).toList(),
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

Files _$FilesFromJson(Map<String, dynamic> json) => Files(
      id: json['id'] as String?,
      name: json['name'] as String,
      folderId: json['folderId'] as String?,
      createdBy: json['createdBy'] as String?,
      size: json['size'] as int,
      workFlow: json['workFlow'] == null
          ? null
          : WorkFlow.fromJson(json['workFlow'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FilesToJson(Files instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'folderId': instance.folderId,
      'createdBy': instance.createdBy,
      'size': instance.size,
      'workFlow': instance.workFlow?.toJson(),
    };

WorkFlow _$WorkFlowFromJson(Map<String, dynamic> json) => WorkFlow();

Map<String, dynamic> _$WorkFlowToJson(WorkFlow instance) => <String, dynamic>{};
