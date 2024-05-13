import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = 'http://localhost:8000/api/register';

  static Future registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      body: {
        'username': username,
        'email': email,
        'password': password,
      },
    );
  }
}
