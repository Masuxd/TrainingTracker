import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';
import 'dart:html' as html; // Only used for web
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

/// Master function to handle requests for both Web and Mobile
Future<Response?> makeRequest(
  String url, {
  String method = 'GET',
  Map<String, dynamic>? data,
}) async {
  if (kIsWeb) {
    return await _makeWebRequest(url, method: method, data: data);
  } else if (Platform.isAndroid || Platform.isIOS) {
    return await _makeMobileRequest(url, method: method, data: data);
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}

// Mobile-specific request handling with Dio and CookieManager
Future<Response?> _makeMobileRequest(
  String url, {
  String method = 'GET',
  Map<String, dynamic>? data,
}) async {
  var dio = Dio();

  // Use CookieJar and Dio's CookieManager for automatic cookie handling
  var cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));

  try {
    Response response;
    if (method == 'POST') {
      response = await dio.post(url, data: data);
    } else if (method == 'GET') {
      response = await dio.get(url);
    } else {
      throw UnsupportedError('Unsupported HTTP method');
    }
    return response;
  } catch (e) {
    print("Request failed on Mobile: $e");
    return null;
  }
}

// Web-specific request handling with HttpRequest and withCredentials
Future<Response?> _makeWebRequest(
  String url, {
  String method = 'GET',
  Map<String, dynamic>? data,
}) async {
  final request = html.HttpRequest();
  request.open(method, url);
  request.withCredentials = true; // Enable cookies for web requests

  if (method == 'POST') {
    request.setRequestHeader('Content-Type', 'application/json');
    request.send(jsonEncode(data));
  } else {
    request.send();
  }

  await request.onLoadEnd.first;
  if (request.status == 200 || request.status == 201) {
    return Response(
      requestOptions: RequestOptions(path: url),
      data: request.responseText,
      statusCode: request.status,
    );
  } else {
    print("Request failed on Web");
    return null;
  }
}

Future<bool> fetchData(String url) async {
  final response = await makeRequest(url);
  if (response != null && response.statusCode == 200) {
    print("Data fetched successfully");
    return true;
  }
  return false;
}

// Wrapper functions for login, register, and logout using makeRequest
Future<bool> login(String url, Map<String, dynamic> credentials) async {
  final response = await makeRequest(url, method: 'POST', data: credentials);
  if (response != null && response.statusCode == 200) {
    print("Login successful");
    return await fetchData('https://localhost:3000/exercise/');
  }
  return false;
}

Future<bool> register(String url, Map<String, dynamic> registrationData) async {
  final response =
      await makeRequest(url, method: 'POST', data: registrationData);
  if (response != null && response.statusCode == 201) {
    print("Registration successful");
    return await login('https://localhost:3000/auth/login', {
      'username': registrationData['email'],
      'password': registrationData['password'],
    });
  }
  return false;
}

Future<bool> logout(String url) async {
  final response = await makeRequest(url, method: 'GET');
  if (response != null && response.statusCode == 200) {
    print("Logout successful");
    return true;
  }
  return false;
}
