import 'package:flutter/material.dart';

import 'api/api_client.dart'; // Importing the request function
import '../classes/training_session.dart'; // Importing the TrainingSession class
import '../classes/set.dart'; // Importing the Set class
import '../classes/rep.dart';
import '../classes/exercise.dart';

/// Function to post a training session to the API
Future<bool> postWorkout(TrainingSession session) async {
  final response = await request(
    'workout/save',
    method: 'POST',
    data: session.toJson(), // Convert session to JSON
  );

  if (response != null && response.statusCode == 201) {
    print("Workout posted successfully");
    return true;
  } else {
    print("Failed to post workout");
    return false;
  }
}

Future<TrainingSession?> fetchWorkout(String id) async {
  try {
    final response = await request('workout/$id');
    debugPrint(response?.statusCode.toString());
    if (response != null && response.statusCode == 200) {
      return TrainingSession.fromJson(
          response.data); // Convert JSON to TrainingSession
    } else {
      print("Failed to fetch workout");
      return null;
    }
  } catch (e) {
    print("Error fetching workout: $e");
    return null;
  }
}

Future<List<TrainingSession>?> fetchWorkoutList() async {
  try {
    final response = await request('workout/list');
    if (response != null && response.statusCode == 200) {
      List<dynamic> data = response.data;
      debugPrint(data.toString());
      return data
          .map((json) => TrainingSession.fromJson(json))
          .toList(); // Convert JSON to list of TrainingSession
    } else {
      print("Failed to fetch workout");
      return null;
    }
  } catch (e) {
    print("Error fetching workout: $e");
    return null;
  }
}

TrainingSession generateWorkout() {
  return TrainingSession(
    sessionId: "672a15667182a036b826ac0a",
    name: "Test session",
    isPlan: false,
    startTime: DateTime.parse("2023-10-01T10:00:00Z"),
    endTime: DateTime.parse("2023-10-01T11:00:00Z"),
    finished: true,
    sets: [
      Set(
        //exerciseId: "672a15667182a036b826ac0a",
        setId: "672a1566718thdrt6b826ac0a",
        exercise: Exercise(
          exerciseId: "672a15667182a036b826ac0a",
          name: "Bench press",
          weight: true,
          distance: false,
          duration: false,
          speed: false,
        ),
        restTime: 60,
        finished: true,
        rep: [
          Rep(
            repetitions: 10,
            weight: 50,
            duration: 0,
            distance: 0,
            speed: 0,
            finished: true,
          ),
        ],
        widgetId: "672a15667182a036b826acrdht",
      ),
      Set(
        //exerciseId: "672a15667182a036b826ac12",
        setId: "672a15667rgr036b826ac12",
        exercise: Exercise(
          exerciseId: "672a15667182a036b826ac12",
          name: "Squats",
          weight: true,
          distance: false,
          duration: false,
          speed: false,
        ),
        restTime: 60,
        finished: true,
        rep: [
          Rep(
            repetitions: 12,
            weight: 0,
            duration: 0,
            distance: 0,
            speed: 0,
            finished: true,
          ),
        ],
        widgetId: "672a156hbtrdh2a036b826acrdht",
      ),
    ],
  );
}
