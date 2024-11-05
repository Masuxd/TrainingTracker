import 'dart:convert';
import 'package:http/http.dart' as http;
import '../cookie_storage.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:3000/auth';
  static Map<String, String> headers = {};

  static Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      // Extract cookies from the response headers
      String? rawCookie = response.headers['set-cookie'];
      await CookieStorage.parseAndStoreCookies(rawCookie!);
      headers = await CookieStorage.loadCookies();
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> logout() async {
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      headers.remove('connect.sid');
      await CookieStorage.deleteCookie('connect.sid');
      return true;
    } else {
      return false;
    }
  }

  static Future<http.Response> fetchProtectedResource() async {
    // Ensure the Cookie header is correctly formatted
    final cookieHeader =
        headers.entries.map((e) => '${e.key}=${e.value}').join('; ');

    final response = await http.get(
      Uri.parse('$baseUrl/protected'),
      headers: {
        'Cookie': cookieHeader,
      },
    );
    return response;
  }
}
