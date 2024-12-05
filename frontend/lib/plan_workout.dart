import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'common/widgets/layout_widget.dart';
import 'common/widgets/workout_widget.dart';
import 'common/widgets/select_workout.dart';
import 'common/classes/training_session.dart';
import './common/classes/exercise.dart';
import 'dart:async';
import 'common/classes/set.dart' as model;
import 'common/services/exercise_service.dart';
import 'common/services/training_session_service.dart';

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

  Future<void> addWorkout(String workout) async {
    hasWorkout = true;

    Exercise? exercise = await fetchExercise(workout);
    if (exercise != null) {
      final widgetId = Uuid().v4();
      workouts.add({
        'workoutId': exercise.exerciseId,
        'widgetId': widgetId,
      });
      //debugPrint('Workout list: $workouts');

      session?.sets.add(
        model.Set(
          setId: Uuid().v4(),
          exerciseId: workout,
          rep: [],
          widgetId: widgetId,
          restTime: 0,
        ),
      );

      notifyListeners();
    }
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
    if (session == null || session!.sets.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No plan to save.'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    session?.startTime = DateTime.now();
    session?.endTime = DateTime.now();

    postWorkout(session!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Workout plan saved'),
        duration: Duration(seconds: 3),
      ),
    );

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
                    String? selectedWorkoutId =
                        await selectWorkout.show(context);
                    if (selectedWorkoutId != null) {
                      context
                          .read<PlanWorkoutState>()
                          .addWorkout(selectedWorkoutId);
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
                                //debugPrint('Tättäträä');
                                final workout = workoutState.workouts[index];
                                final workoutId =
                                    workout['workoutId'] as String?;
                                final widgetId = workout['widgetId'] as String?;
                                if (workoutId == null || widgetId == null) {
                                  return SizedBox
                                      .shrink(); // Handle null values
                                }
                                //debugPrint('Workout: $workoutId');
                                //debugPrint('Widget ID: $widgetId');
                                final session = workoutState.session!;
                                return WorkoutWidget(
                                  selectedExerciseId: workoutId,
                                  session: session,
                                  widgetId: widgetId,
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
