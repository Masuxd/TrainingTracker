import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'common/widgets/layout_widget.dart';
import 'common/widgets/workout_widget.dart';
import 'common/widgets/select_workout.dart';
import 'common/classes/training_session.dart';
import './common/classes/exercise.dart';
import 'mock_data/mock_exercises.dart';
import 'mock_data/mock_users.dart';
import 'dart:async';
import 'common/classes/set.dart' as model;

class PlanWorkout extends StatelessWidget {
  const PlanWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlanWorkoutState(),
      child: MainLayout(
        currentIndex: 0,
        child: PlanWorkoutScreen(),
      ),
    );
  }
}

class PlanWorkoutState extends ChangeNotifier {
  bool hasWorkout = false;
  List<Map<String, dynamic>> workouts = [];
  TrainingSession? session;

  void createPlan() {
    //final mockUser = mockUsers[0];
    final sessionId = Uuid().v4();
    session = TrainingSession(
      sessionId: sessionId,
      name: 'Plan',
      isPlan: true,
      startTime: null,
      endTime: null,
      finished: false,
      sets: [],
    );
  }

  PlanWorkoutState() {
    createPlan();
  }

  void addWorkout(Exercise workout) {
    hasWorkout = true;

    final widgetId = Uuid().v4();
    workouts.add({
      'workout': workout,
      'widgetId': widgetId,
    });

    final newSet = model.Set(
      setId: Uuid().v4(),
      exerciseId: workout.exerciseId,
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

  Future<void> savePlan(BuildContext context) async {
    if (session == null) {
      print("No plan to save.");
      return;
    }

    session?.startTime = DateTime.now();
    session?.endTime = DateTime.now();

    final body = {
      "id": session!.sessionId,
      "name": session!.name,
      "start_time": session!.startTime!.toIso8601String(),
      "end_time": session!.endTime!.toIso8601String(),
      "finished": true,
      "set": session!.sets
          .map((set) => {
                "exerciseId": set.exerciseId,
                "reps": set.rep.map((rep) => rep.toJson()).toList(),
                "rest_time": set.restTime,
              })
          .toList(),
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Workout plan saved'),
        duration: Duration(seconds: 3),
      ),
    );

    debugPrint(body.toString());
    Navigator.pushNamed(context, '/home');
  }
}

class PlanWorkoutScreen extends StatelessWidget {
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
                  decoration: InputDecoration(labelText: 'Plan Name'),
                  onChanged: (value) {
                    context.read<PlanWorkoutState>().updateSessionName(value);
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
                          .read<PlanWorkoutState>()
                          .addWorkout(selectedExercise);
                    }
                  },
                  child: Text('Add Exercise +'),
                ),
                Consumer<PlanWorkoutState>(
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
                                        .read<PlanWorkoutState>()
                                        .removeWorkout(index);
                                  },
                                );
                              },
                            ),
                          )
                        : Column(
                            children: [
                              SizedBox(height: 16),
                              Text('Add Exercises to your plan'),
                            ],
                          );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 30),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<PlanWorkoutState>().savePlan(context);
                        },
                        child: Text('Save Plan'),
                      ),
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
