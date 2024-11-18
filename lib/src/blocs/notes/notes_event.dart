import 'package:equatable/equatable.dart';

import '../../models/note.model.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class GetNotesEvent extends NotesEvent {
  const GetNotesEvent();
  @override
  List<Object> get props => [];
}

class SaveNoteEvent extends NotesEvent {
  final NoteModel note;
  const SaveNoteEvent(this.note);
  @override
  List<Object> get props => [];
}

class DeleteNoteEvent extends NotesEvent {
  final String? id;
  const DeleteNoteEvent(this.id);
  @override
  List<Object> get props => [];
}
