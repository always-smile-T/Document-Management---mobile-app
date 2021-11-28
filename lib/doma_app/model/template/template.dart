import 'package:json_annotation/json_annotation.dart';

part 'template.g.dart';
//run (flutter pub run build_runner build)

@JsonSerializable(explicitToJson: true)
class Template_ {
  String? id;
  String? name;
  String? description;
  String? parentId;
  String? createdBy;
  String? updatedDate;
  int? size;
  List<Folders>? folders;
  List<Templates>? templates;

  Template_(
      {required this.id,
        required this.name,
        required this.description,
        required this.parentId,
        required this.createdBy,
        required this.updatedDate,
        required this.size,
        required this.folders,
        required this.templates});

  factory Template_.fromJson(Map<String, dynamic> json) => _$Template_FromJson(json);

  Map<String, dynamic> toJson() => _$Template_ToJson(this);
}

@JsonSerializable()
class Folders {
  String? id;
  String name;
  String? description;
  String? parentId;
  String? createdBy;
  String? updatedDate;
  int size;

  Folders(
      { required this.id,
        required this.name,
        required this.description,
        required this.parentId,
        required this.createdBy,
        required this.updatedDate,
        required this.size});

  factory Folders.fromJson(Map<String, dynamic> json) => _$FoldersFromJson(json);

  Map<String, dynamic> toJson() => _$FoldersToJson(this);
}

@JsonSerializable()
class Templates {
  String? id;
  String name;
  String? folderId;
  String? createdBy;
  int size;

  Templates({required this.id, required this.name, required this.folderId, required this.createdBy, required this.size});

  factory Templates.fromJson(Map<String, dynamic> json) => _$TemplatesFromJson(json);

  Map<String, dynamic> toJson() => _$TemplatesToJson(this);
}
