import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MockClient extends http.BaseClient {
  final SharedPreferences prefs;

  MockClient(this.prefs);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // Simulate a delay
    await Future.delayed(Duration(milliseconds: 200));

    if (request is http.Request) {
      List<String> parts = request.url.path.toString().split("/").where((part) => part.isNotEmpty).toList();
      switch (request.method) {
        case 'GET':
          if(parts[0] == 'notes'){
            return _handleGetNotes(request, parts[0]);
          }
          else{
            return _buildResponse('Not found', 404);
          }

        case 'POST':
          if(parts[0] == 'notes'){
            return _handlePost(request, parts[0]);
          }
          else{
            return _buildResponse('Not found', 404);
          }
        case 'PUT':
          if(parts[0] == 'notes'){
            return _handlePut(request, parts[0]);
          }
          else{
            return _buildResponse('Not found', 404);
          }

        case 'DELETE':
          if(parts[0] == 'notes'){
            return _handleDelete(request, parts[0]);
          }
          else{
            return _buildResponse('Not found', 404);
          }
        default:
          return _buildResponse('Unsupported HTTP method', 405);
      }
    }
    return _buildResponse('Unsupported request type', 400);  // Bad Request
  }

  Future<http.StreamedResponse> _handleGetNotes(http.Request request, String key) async {
    // var note1 = new NoteModel(id: Uuid().v4(), title: "Test1", content: "This is note 1");
    // var note2 = new NoteModel(id: Uuid().v4(), title: "Test2", content: "This is note 2");
    // var note3 = new NoteModel(id: Uuid().v4(), title: "Test3", content: "This is note 3, This is not3 3, This is note 3");
    // var note4 = new NoteModel(id: Uuid().v4(), title: "Test4", content: "This is note 4");
    // var note5 = new NoteModel(id: Uuid().v4(), title: "Test5", content: "This is note 5");
    // List<NoteModel> notes = [note1, note2, note3, note4, note5];

    //List<Map<String, dynamic>> notesJson = notes.map((note) => note.toJson()).toList();
    //String encodedNotes = json.encode(notesJson);
    //await prefs.setString(key, encodedNotes);

    String? data = prefs.getString(key);
    if (data != null) {
      return _buildResponse(data, 200);
    } else {
      return _buildResponse('No Content', 204 );
    }
  }

  Future<http.StreamedResponse> _handlePost(http.Request request, String key) async {
    String body = request.body;
    prefs.setString(key, body);
    return _buildResponse('Created', 201);
  }

  Future<http.StreamedResponse> _handlePut(http.Request request, String key) async {
    String body = request.body;
    prefs.setString(key, body);
    return _buildResponse('Updated', 200);
  }

  Future<http.StreamedResponse> _handleDelete(http.Request request, String key) async {
    prefs.remove(key);
    return _buildResponse('Deleted', 200);
  }

  http.StreamedResponse _buildResponse(String body, int statusCode) {
    final stream = Stream.value(utf8.encode(body));
    final response = http.StreamedResponse(stream, statusCode, headers: {'Content-Type': 'application/json'});
    return response;
  }
}
