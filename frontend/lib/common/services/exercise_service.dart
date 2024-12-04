import 'package:frontend/common/classes/exercise.dart';

import 'api/api_client.dart';

Future<Exercise?> fetchExercise(id) async {
  try {
    final response = await request('exercise/$id');
    if (response != null) {
      if (response.statusCode == 200) {
        Exercise exercise = Exercise.fromJson(response.data);
        return exercise;
      } else if (response.statusCode == 404) {
        print("Error: Exercises not found (404)");
        return null;
      } else if (response.statusCode == 500) {
        print("Error: Internal Server Error (500)");
        return null;
      } else {
        print("Error: Unexpected status code ${response.statusCode}");
        return null;
      }
    } else {
      print("Error: No response received");
      return null;
    }
  } catch (e) {
    print("Error fetching exercises: $e");
    return null;
  }
}

Future<List<Exercise>?> fetchExercises() async {
  try {
    final response = await request('exercise/');
    if (response != null) {
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Exercise> exercises =
            data.map((json) => Exercise.fromJson(json)).toList();
        return exercises;
      } else if (response.statusCode == 404) {
        print("Error: Exercises not found (404)");
        return null;
      } else if (response.statusCode == 500) {
        print("Error: Internal Server Error (500)");
        return null;
      } else {
        print("Error: Unexpected status code ${response.statusCode}");
        return null;
      }
    } else {
      print("Error: No response received");
      return null;
    }
  } catch (e) {
    print("Error fetching exercises: $e");
    return null;
  }
}

Future<List<Exercise>?> searchExercises(String query) async {
  try {
    final response = await request('exercise/search/$query');
    if (response != null) {
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Exercise> exercises =
            data.map((json) => Exercise.fromJson(json)).toList();
        return exercises;
      } else if (response.statusCode == 404) {
        print("Error: Exercises not found (404)");
        return null;
      } else if (response.statusCode == 500) {
        print("Error: Internal Server Error (500)");
        return null;
      } else {
        print("Error: Unexpected status code ${response.statusCode}");
        return null;
      }
    } else {
      print("Error: No response received");
      return null;
    }
  } catch (e) {
    print("Error fetching exercises: $e");
    return null;
  }
}
