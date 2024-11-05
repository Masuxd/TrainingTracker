import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../cookie_storage.dart';

import 'package:dio/dio.dart';

class AuthService {
  static const String baseUrl = 'https://localhost:3000/auth';

  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://localhost:3000/auth',
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  AuthService() {
    // Intercept responses to manually manage cookies
    _dio.interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) async {
        // Check if the 'set-cookie' header is present in the response
        if (response.headers.map.containsKey('set-cookie')) {
          // Extract the raw 'Set-Cookie' header
          final rawCookie = response.headers['set-cookie'];
          if (rawCookie != null && rawCookie.isNotEmpty) {
            // Save the cookie using FlutterCookieManager
            await CookieStorage.parseAndStoreCookies(rawCookie.join('; '));
            print("Cookie stored successfully.");
          }
        }
        handler.next(response);
      },
    ));
  }

  Future<bool> login(String username, String password) async {
    try {
      // Make the POST request to the login endpoint
      final response = await _dio.post(
        '/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        print("Login successful.");
        return await fetchProtectedData();
      } else {
        print("Login failed with status: ${response.statusCode}");
        return false;
      }
    } catch (error) {
      print("An error occurred: $error");
      return false;
    }
  }

  Future<bool> register(String username, String email, String password) async {
    debugPrint('Registering user: $username, $email, $password');
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'username': username, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      // Automatically log in the user after successful registration
      return await login(email, password);
    } else {
      return false;
    }
  }

  static Map<String, String> headers = {};

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

  static Future<bool> fetchProtectedData() async {
    try {
      final response = await http.get(
        Uri.parse('https://localhost:3000/exercise/'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        debugPrint('Protected data fetched successfully.');
        debugPrint('Data: ${response.body}');
        return true;
      } else {
        debugPrint(
            'Failed to fetch protected data with status: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      debugPrint('An error occurred while fetching protected data: $error');
      return false;
    }
  }
}
