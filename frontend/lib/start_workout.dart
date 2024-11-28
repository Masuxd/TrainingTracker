import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/widgets/layout_widget.dart';
import 'common/widgets/workout_widget.dart';
import 'common/widgets/select_workout.dart';
import './common/models/exercise.dart';
import 'mock_data/mock_exercises.dart';
import './common/models/training_session.dart';
import '../mock_data/mock_users.dart';
import 'dart:async';
import 'package:uuid/uuid.dart';
import 'common/models/set.dart' as model;
import 'package:http/http.dart' as http;

class StartWorkout extends StatelessWidget {
  const StartWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StartWorkoutState(),
      child: MainLayout(
        currentIndex: 0,
        child: StartWorkoutScreen(),
      ),
    );
  }
}

class StartWorkoutState extends ChangeNotifier {
  late Timer _timer;
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;

  bool hasWorkout = false;
  List<Map<String, dynamic>> workouts = [];
  TrainingSession? session;

  void startSession() {
    final mockUser = mockUsers[0];
    final sessionId = Uuid().v4();
    session = TrainingSession(
      sessionId: sessionId,
      userId: mockUser.id,
      startTime: DateTime.now(),
      endTime: null,
      sets: [],
    );
  }

  StartWorkoutState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _seconds++;

      if (_seconds == 60) {
        _seconds = 0;
        _minutes++;
      }

      if (_minutes == 60) {
        _minutes = 0;
        _hours++;
      }

      notifyListeners();
    });

    startSession();
  }

  int get seconds => _seconds;
  int get minutes => _minutes;
  int get hours => _hours;

  void addWorkout(Exercise workout) {
    hasWorkout = true;

    final widgetId = Uuid().v4();
    workouts.add({
      'workout': workout,
      'widgetId': widgetId,
    });

    final newSet = model.Set(
      setId: Uuid().v4(),
      exercise: workout,
      rep: [],
      widgetId: widgetId,
    );

    session?.sets.add(newSet);

    //debugPrint('Adding new workout: ${workout.name}');
    //debugPrint('Widget ID: ${newSet.widgetId}, Set ID: ${newSet.setId}');
    notifyListeners();
  }

  void removeWorkout(int index) {
    workouts.removeAt(index);
    notifyListeners();
  }

  Future<void> saveSession() async {
    if (session == null) {
      print("No active session to save.");
      return;
    }

    session?.endTime = DateTime.now();

    /*final url = Uri.parse('http://localhost:3000/sessions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer <your-session-token>'
    };*/

    final body = {
      "start_time": session!.startTime.toIso8601String(),
      "end_time": session!.endTime!.toIso8601String(),
      "finished": true,
      "set": session!.sets
          .map((set) => {
                "exercise": set.exercise.name,
                "reps": set.rep,
              })
          .toList(),
    };

    //final body = session!.toJson();
    debugPrint('Session start time: ${body['start_time']}');
    debugPrint('Session end time: ${body['end_time']}');
    debugPrint('Session sets: ${body['set']}');

    /*try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 201) {
        print("Session saved successfully.");
      } else {
        print("Failed to save session. Status code: ${response.body}");
      }
    } catch (error) {
      print("Failed to save session. Error: $error");
    }*/
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class StartWorkoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              final selectWorkout = SelectWorkout();
              String? selectedWorkout = await selectWorkout.show(context);
              if (selectedWorkout != null) {
                Exercise selectedExercise = mockExercises
                    .firstWhere((exercise) => exercise.name == selectedWorkout);
                context.read<StartWorkoutState>().addWorkout(selectedExercise);
              }
            },
            child: Text('Add Exercise +'),
          ),
          Consumer<StartWorkoutState>(
            builder: (
              context,
              workoutState,
              child,
            ) {
              return workoutState.hasWorkout
                  ? SizedBox(
                      height: 500,
                      child: ListView.builder(
                        itemCount: workoutState.workouts.length,
                        itemBuilder: (context, index) {
                          final workout = workoutState.workouts[index];
                          return WorkoutWidget(
                            selectedExercise: workout['workout'] as Exercise,
                            widgetId: workout['widgetId'],
                            onDelete: () {
                              context
                                  .read<StartWorkoutState>()
                                  .removeWorkout(index);
                            },
                          );
                        },
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(height: 16),
                        Text('Add Exercises to your workout'),
                      ],
                    );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<StartWorkoutState>(
                builder: (context, workoutState, child) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Exercise time: ${workoutState.hours} h ${workoutState.minutes} min ${workoutState.seconds} s',
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                },
              ),
              SizedBox(width: 30),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: context.read<StartWorkoutState>().saveSession,
                  child: Text('Finish'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
