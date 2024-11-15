// training_session_service.dart
import 'request_service.dart'; // Importing the request function

/// Function to post a training session to the API
Future<bool> postTrainingSession(Map<String, dynamic> sessionData) async {
  final response = await request(
    'https://localhost:3000/trainingSession/save',
    method: 'POST',
    data: sessionData, // Session data will be passed here
  );

  if (response != null && response.statusCode == 201) {
    print("Training session posted successfully");
    return true;
  } else {
    print("Failed to post training session");
    return false;
  }
}

/// Example function to prepare training session data similar to the curl request
Map<String, dynamic> prepareTrainingSessionData() {
  return {
    "start_time": "2023-10-01T10:00:00Z",
    "end_time": "2023-10-01T11:00:00Z",
    "finished": true,
    "set": [
      {
        "exercise": "672a15667182a036b826ac0a",
        "recovery_time": "2023-10-01T10:05:00Z",
        "finished": true,
        "rep": [
          {
            "repetitions": 10,
            "weight": 50,
            "duration": "2023-10-01T10:00:30Z",
            "distance": 100,
            "speed": 10,
            "finished": true
          },
          {
            "repetitions": 8,
            "weight": 55,
            "duration": "2023-10-01T10:01:00Z",
            "distance": 100,
            "speed": 10,
            "finished": true
          }
        ]
      },
      {
        "exercise": "672a15667182a036b826ac12",
        "recovery_time": "2023-10-01T10:15:00Z",
        "finished": true,
        "rep": [
          {
            "repetitions": 12,
            "weight": 40,
            "duration": "2023-10-01T10:10:30Z",
            "distance": 100,
            "speed": 10,
            "finished": true
          }
        ]
      }
    ]
  };
}
