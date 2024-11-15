// auth_service.dart
import 'package:flutter/material.dart';

import 'request_service.dart'; // Importing the request function
import 'session_service.dart'; // Importing the postTrainingSession function

/// Function for logging in
Future<bool> login(String url, Map<String, dynamic> credentials) async {
  final response = await request(url, method: 'POST', data: credentials);
  if (response != null && response.statusCode == 200) {
    print("Login successful");
    Map<String, dynamic> trainingSessionData = prepareTrainingSessionData();
    bool result = await postTrainingSession(trainingSessionData);
    debugPrint("Training session posted: $result");
    return true;
  }
  return false;
}

/// Function for registering
Future<bool> register(String url, Map<String, dynamic> registrationData) async {
  final response = await request(url, method: 'POST', data: registrationData);
  if (response != null && response.statusCode == 201) {
    print("Registration successful");
    // Automatically login after registration
    return await login('https://localhost:3000/auth/login', {
      'username': registrationData['email'],
      'password': registrationData['password'],
    });
  }
  return false;
}

/// Function for logging out
Future<bool> logout(String url) async {
  final response = await request(url, method: 'GET');
  if (response != null && response.statusCode == 200) {
    print("Logout successful");
    return true;
  }
  return false;
}
