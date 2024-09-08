import 'dart:convert';
import 'package:api_requstes/note.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl =
      "http://10.0.2.2:3000/books"; // Use 10.0.2.2 for Android emulator

  Future<List<Note>> fetchNote() async {
    try {
      final rs = await http.get(Uri.parse(baseUrl));

      if (rs.statusCode == 200) {
        List<dynamic> body = json.decode(rs.body);
        return body.map((dynamic item) => Note.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch notes');
      }
    } catch (e) {
      throw Exception('Failed to fetch notes: $e');
    }
  }

  Future<Note> createNote(Note note) async {
    final rs = await http.post(
      Uri.parse(baseUrl),
      body: json.encode(note.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (rs.statusCode == 201 || rs.statusCode == 200) {
      return Note.fromJson(json.decode(rs.body));
    } else {
      final responseBody = json.decode(rs.body);
      throw Exception(
          'Failed to create note: ${rs.statusCode} ${responseBody}');
    }
  }

  Future<Note> updateNote(String id, Note note) async {
    try {
      final rs = await http.put(
        Uri.parse('$baseUrl/$id'),
        body: json.encode(note.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (rs.statusCode == 200) {
        return Note.fromJson(json.decode(rs.body));
      } else {
        throw Exception('Failed to fetch notes');
      }
    } catch (e) {
      throw Exception('Failed to fetch notes: $e');
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      final rs = await http.delete(Uri.parse('$baseUrl/$id'));

      if (rs.statusCode != 200) {
        throw Exception('Failed to fetch notes');
      }
    } catch (e) {
      throw Exception('Failed to fetch notes: $e');
    }
  }
}
