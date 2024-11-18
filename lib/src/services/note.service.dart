import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/note.model.dart';
import 'mock_client.dart';

class NoteService {
  final MockClient _client;

  NoteService(SharedPreferences prefs) : _client = MockClient(prefs);

  Future<List<NoteModel>> fetchNotes() async {
    final response = await _client.get(Uri.parse('/notes'));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((json) => NoteModel.fromJson(json))
          .toList()
        ..sort((a, b) => b.updatedOn.compareTo(a.updatedOn));
    }
    else if(response.statusCode == 204){
      List<NoteModel> notes = [];
      return notes;
    }
    else {
      throw Exception('Failed to load notes');
    }
  }

  Future<NoteModel?> fetchNoteById(String? id) async {
    List<NoteModel> notes = await fetchNotes();
    //final response = await _client.get(Uri.parse('/notes/$id'));
    // if (response.statusCode == 200) {
    //   return NoteModel.fromJson(jsonDecode(response.body));
    // }
    if (notes.isNotEmpty) {
      return notes.where((x) => x.id == id).firstOrNull;
    }
    else{
      return null;
    }
  }

  Future<NoteModel?> addNote(NoteModel note) async {
    List<NoteModel> notes = await fetchNotes();
    notes.add(note);
    List<Map<String, dynamic>> notesJson = notes.map((note) => note.toJson()).toList();
    String encodedNotes = json.encode(notesJson);
    final response = await _client.post(
      Uri.parse('/notes'),
      headers: {'Content-Type': 'application/json'},
      body: encodedNotes,
    );
    if (response.statusCode == 201) {
      NoteModel? created = await fetchNoteById(note.id);
      return created;
    } else {
      throw Exception('Failed to add note');
    }
  }

  Future<NoteModel?> updateNote(String? id, NoteModel note) async {
    List<NoteModel> notes = await fetchNotes();
    notes.removeWhere((x) => x.id == id);
    notes.add(note);
    List<Map<String, dynamic>> notesJson = notes.map((note) => note.toJson()).toList();
    String encodedNotes = json.encode(notesJson);
    final response = await _client.put(
      Uri.parse('/notes/$id'),
      headers: {'Content-Type': 'application/json'},
      body: encodedNotes,
    );
    if (response.statusCode == 200) {
      NoteModel? updated = await fetchNoteById(note.id);
      return updated;
    }
    return null;
  }

  Future<bool> deleteNote(String? id) async {
    List<NoteModel> notes = await fetchNotes();
    notes.removeWhere((x) => x.id == id);
    List<Map<String, dynamic>> notesJson = notes.map((note) => note.toJson()).toList();
    String encodedNotes = json.encode(notesJson);
    // final response = await _client.put(
    //   Uri.parse('/notes/$id'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: encodedNotes,
    // );

    //TODO - Cannot do item delete with shared preferences
    final response = await _client.post(
      Uri.parse('/notes'),
      headers: {'Content-Type': 'application/json'},
      body: encodedNotes,
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to add note');
    }
  }
}