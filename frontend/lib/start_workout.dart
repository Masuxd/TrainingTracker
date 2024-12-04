import 'package:flutter/material.dart';
import 'package:path/path.dart';
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
  //const StartWorkout({super.key});
  final TrainingSession? session;
  const StartWorkout({this.session});

  @override
  Widget build(BuildContext context) {
    final mockUser = mockUsers[0];
    TrainingSession workoutSession;

    workoutSession = session ??
        TrainingSession(
          sessionId: Uuid().v4(),
          name: 'Workout',
          isPlan: false,
          userId: mockUser.id,
          startTime: DateTime.now(),
          endTime: null,
          sets: [],
        );
    debugPrint('Start workout SessionId: ${session?.sessionId}');
    return ChangeNotifierProvider(
      create: (context) => StartWorkoutState(workoutSession),
      child: MainLayout(
        currentIndex: 0,
        child: StartWorkoutScreen(),
      ),
    );
  }
}

class StartWorkoutState extends ChangeNotifier {
  late TrainingSession? session;
  late Timer _timer;
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;

  bool hasWorkout = false;
  List<Map<String, dynamic>> workouts = [];

  void startSession() {
    debugPrint('SessionId startSession(): ${session!.sessionId}');
    final mockUser = mockUsers[0];
    final sessionId = Uuid().v4();
    session = session ??
        TrainingSession(
          sessionId: sessionId,
          name: 'Workout',
          isPlan: false,
          userId: mockUser.id,
          startTime: DateTime.now(),
          endTime: null,
          sets: [],
        );
    for (var set in session!.sets) {
      workouts.add({
        'workout': set.exercise,
        'widgetId': set.widgetId,
      });
    }
    if (workouts.isNotEmpty) {
      hasWorkout = true;
    }

    debugPrint('Session start time: ${session!.sessionId}');
  }

  StartWorkoutState(this.session) {
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
      restTime: 0,
    );

    session?.sets.add(newSet);
    notifyListeners();
  }

  void removeWorkout(int index) {
    workouts.removeAt(index);
    notifyListeners();
  }

  void updateSessionName(String name) {
    session?.name = name;
    notifyListeners();
  }

  Future<void> saveSession(BuildContext context) async {
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
      "id": session!.sessionId,
      "name": session!.name,
      "start_time": session!.startTime!.toIso8601String(),
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
    debugPrint('Body Session id: ${body['id']}');
    debugPrint('Session name: ${body['name']}');
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Workout saved'),
        duration: Duration(seconds: 3),
      ),
    );

    Navigator.pushNamed(context, '/home');
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class StartWorkoutScreen extends StatelessWidget {
  final TrainingSession? session;
  const StartWorkoutScreen({super.key, this.session});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: (context
                                    .watch<StartWorkoutState>()
                                    .session
                                    ?.name ==
                                "Workout" ||
                            context.watch<StartWorkoutState>().session?.name ==
                                "Plan")
                        ? 'Workout Name'
                        : context.watch<StartWorkoutState>().session?.name,
                  ),
                  onChanged: (value) {
                    context.read<StartWorkoutState>().updateSessionName(value);
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final selectWorkout = SelectWorkout();
                    String? selectedWorkout = await selectWorkout.show(context);
                    if (selectedWorkout != null) {
                      Exercise selectedExercise = mockExercises.firstWhere(
                          (exercise) => exercise.name == selectedWorkout);
                      context
                          .read<StartWorkoutState>()
                          .addWorkout(selectedExercise);
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
                                final session = workoutState.session!;
                                return WorkoutWidget(
                                  selectedExercise:
                                      workout['workout'] as Exercise,
                                  session: session,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 50.0),
                      child: Consumer<StartWorkoutState>(
                        builder: (context, workoutState, child) {
                          return Text(
                            'Exercise time: ${workoutState.hours} h ${workoutState.minutes} min ${workoutState.seconds} s',
                            style: const TextStyle(fontSize: 14),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 30),
                    ElevatedButton(
                      onPressed: () => context
                          .read<StartWorkoutState>()
                          .saveSession(context),
                      child: Text('Finish'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
