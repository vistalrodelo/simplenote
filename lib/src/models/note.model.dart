import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.model.freezed.dart'; // generated code will go
part 'note.model.g.dart';       // json_serializable

@freezed
//@JsonSerializable()
class NoteModel with _$NoteModel {
  const factory NoteModel({
    required String? id,
    required String? title,
    required String? content,
    required DateTime createdOn,
    required DateTime updatedOn,
  }) = _NoteModel;

  // You can also add JSON serialization methods if needed:
  factory NoteModel.fromJson(Map<String, dynamic> json) => _$NoteModelFromJson(json);
  //Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}