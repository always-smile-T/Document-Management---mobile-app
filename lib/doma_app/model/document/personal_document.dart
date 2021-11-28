
import 'package:json_annotation/json_annotation.dart';

part 'personal_document.g.dart';

@JsonSerializable(explicitToJson: true)
class Document {
  String? id;
  String? name;
  String? description;
  String? parentId;
  String? createdBy;
  String? updatedDate;
  int? size;
  List<Folders>? folders;
  List<Files>? files;

  Document({required this.id, required this.name, required this.description, required this.parentId, required this.createdBy, required this.updatedDate, required this.size, required this.folders, required this.files});
  factory Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);

}

@JsonSerializable(explicitToJson: true)
class Folders {
  String? id;
  String name;
  String? description;
  String? parentId;
  String? createdBy;
  String? updatedDate;
  int size;

  Folders({required this.id, required this.name, required this.description, required this.parentId, required this.createdBy, required this.updatedDate, required this.size});

  factory Folders.fromJson(Map<String, dynamic> json) => _$FoldersFromJson(json);

  Map<String, dynamic> toJson() => _$FoldersToJson(this);

}

@JsonSerializable(explicitToJson: true)
class Files {
  String? id;
  String name;
  String? folderId;
  String? createdBy;
  int size;
  WorkFlow? workFlow;

  Files({required this.id, required this.name, required this.folderId, required this.createdBy, required this.size, required this.workFlow});

  factory Files.fromJson(Map<String, dynamic> json) => _$FilesFromJson(json);

  Map<String, dynamic> toJson() => _$FilesToJson(this);

}

@JsonSerializable()
class WorkFlow {


  WorkFlow({document});

  factory WorkFlow.fromJson(Map<String, dynamic> json) => _$WorkFlowFromJson(json);

  Map<String, dynamic> toJson() => _$WorkFlowToJson(this);


}
