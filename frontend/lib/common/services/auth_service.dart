import 'api/api_client.dart'; // Importing the request function
import 'api/cookie_storage.dart'; // Importing the CookieStorage class
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Importing the FlutterSecureStorage class

/// Function for logging in
Future<bool> login(Map<String, dynamic> credentials) async {
  final response =
      await request('auth/login', method: 'POST', data: credentials);
  if (response != null && response.statusCode == 200) {
    print("Login successful");
    return true;
  }
  return false;
}

/// Function for registering
Future<bool> register(Map<String, dynamic> registrationData) async {
  final response =
      await request('auth/register', method: 'POST', data: registrationData);
  if (response != null && response.statusCode == 201) {
    print("Registration successful");
    // Automatically login after registration
    return await login({
      'email': registrationData['email'],
      'password': registrationData['password'],
    });
  }
  return false;
}

/// Function for logging out
Future<bool> logout() async {
  final response = await request('auth/logout', method: 'POST');
  if (response != null && response.statusCode == 200) {
    print("Logout successful");
    return true;
  }
  return false;
}

/// Function to attempt login by checking for existing session cookie and verifying the session
Future<bool> attemptLogin() async {
  final secureStorage = FlutterSecureStorage();
  final cookieJar = CookieStorage(secureStorage: secureStorage);

  // Check if the connect.sid cookie exists
  final cookies = await cookieJar.loadForRequest(Uri.parse(baseUrl));
  bool hasSessionCookie = cookies.any((cookie) => cookie.name == 'connect.sid');

  if (hasSessionCookie) {
    // Make a request to verify the session
    final response = await request('auth/verifysession');
    if (response != null && response.statusCode == 200) {
      return true;
    }
  }

  return false;
}


/*

    import 'package:flutter/foundation.dart';
    import '../classes/exercise.dart';
    import '../classes/training_session.dart';
    import './training_session_service.dart';
    import './exercise_service.dart';



    TrainingSession treeni = generateTrainingSession();
    await postTrainingSession(treeni);

    TrainingSession treenihaku =
        (await fetchTrainingSession("673c8432119e00a5f8fdf3c8"))
            as TrainingSession;
    debugPrint(treenihaku.startTime.toString());

    List<TrainingSession> treenit =
        (await fetchTrainingSessionList()) as List<TrainingSession>;
    debugPrint(treenit[0].startTime.toString());

    //debugPrint(treenit.startTime.toString());
    List<Exercise> exercises = await fetchExercises() as List<Exercise>;
    debugPrint("${exercises[0].name} ${exercises[0].id}");
*/