// request_service.dart
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'cookie_storage.dart';
import 'package:flutter/material.dart';

/// Function to make requests using Dio with automatic cookie handling
Future<Response?> request(
  String url, {
  String method = 'GET',
  Map<String, dynamic>? data,
}) async {
  var dio = Dio();

  final secureStorage = FlutterSecureStorage();
  final cookieJar = CookieStorage(secureStorage: secureStorage);
  dio.interceptors.add(CookieManager(cookieJar));
  debugPrint('CookieJar: $cookieJar');
  try {
    Response response;

    // Handle the request based on the HTTP method
    if (method == 'POST') {
      response = await dio.post(url, data: data);
    } else if (method == 'GET') {
      response = await dio.get(url);
    } else {
      throw UnsupportedError('Unsupported HTTP method');
    }

    return response;
  } catch (e) {
    print("Request failed: $e");
    return null;
  }
}
