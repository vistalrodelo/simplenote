import 'package:equatable/equatable.dart';

import '../../models/note.model.dart';

abstract class NotesState extends Equatable {
  const NotesState();
  @override
  List<Object> get props => [];
}

class NotesLoadingState extends NotesState {}
class NotesLoadedState extends NotesState {
  final List<NoteModel> notes;
  const NotesLoadedState(this.notes);

  @override
  List<Object> get props => [notes];
}

class NotesErrorState extends NotesState {
  final String message;

  const NotesErrorState(this.message);

  @override
  List<Object> get props => [message];
}
