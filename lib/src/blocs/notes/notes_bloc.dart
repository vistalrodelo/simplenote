import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/note.service.dart';
import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  late final NoteService _noteService;
  late SharedPreferences _prefs;
  late dynamic notes;

  NotesBloc() : super(NotesLoadingState()) {
    _initializeServices();
    on<GetNotesEvent>(_onGetNotesEvent);
    on<SaveNoteEvent>(_onSaveNotesEvent);
    on<DeleteNoteEvent>(_onDeleteNoteEvent);
  }

  Future<void> _initializeServices() async {
    _prefs = await SharedPreferences.getInstance();
    _noteService = NoteService(_prefs);
  }

  Future<void> _onGetNotesEvent(GetNotesEvent event, Emitter<NotesState> emit) async
  {
    emit(NotesLoadingState());
    try {
      notes = await _noteService.fetchNotes();
      emit(NotesLoadedState(notes));
    }
    catch (e)
    {
      emit(NotesErrorState(e.toString()));
    }
  }

  Future<void> _onSaveNotesEvent(SaveNoteEvent event, Emitter<NotesState> emit) async
  {
    emit(NotesLoadingState());
    try {
      final toUpdate = await _noteService.fetchNoteById(event.note.id);
      if(toUpdate != null){
        await _noteService.updateNote(event.note.id, event.note);
      }
      else{
        await _noteService.addNote(event.note);
      }
      notes = await _noteService.fetchNotes();
      emit(NotesLoadedState(notes));
    }
    catch (e)
    {
      emit(NotesErrorState(e.toString()));
    }
  }
  Future<void> _onDeleteNoteEvent(DeleteNoteEvent event, Emitter<NotesState> emit) async
  {
    emit(NotesLoadingState());
    try {
      await _noteService.deleteNote(event.id);
      notes = await _noteService.fetchNotes();
      emit(NotesLoadedState(notes));
    }
    catch (e)
    {
      emit(NotesErrorState(e.toString()));
    }
  }
}