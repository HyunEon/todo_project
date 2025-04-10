import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class ApiService {
  static const String apiUrl = 'http://127.0.0.1:8000';

  Future<List<dynamic>> fetchTasks() async {
    final response = await http.get(Uri.parse('$apiUrl/tasks/'));
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Error: Failed to request');
    }
  }

  Future<void> createTask(
      String title, String description, String duedate) async {
    final response = await http.post(
      Uri.parse('$apiUrl/tasks/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': title,
        'description': description,
        'is_completed': false,
        'duedate': duedate,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Error: Failed to request');
    }
  }

  Future<void> updateTask(int id, String title, String description,
      bool iscompleted, String duedate, String updateat) async {
    final response = await http.put(
      Uri.parse('$apiUrl/tasks/$id/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': title,
        'description': description,
        'is_completed': iscompleted,
        'duedate': duedate,
        'updated_at': updateat,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Error: Failed to request');
    }
  }
}
