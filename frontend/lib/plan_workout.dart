import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/widgets/layout_widget.dart';
import 'common/widgets/workout_widget.dart';
import 'common/widgets/select_workout.dart';
import './common/models/exercise.dart';
import 'mockExercises.dart';
import 'dart:async';

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
  late Timer _timer;
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;

  bool hasWorkout = false;
  List<Exercise> workouts = [];

  PlanWorkoutState() {
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
  }

  int get seconds => _seconds;
  int get minutes => _minutes;
  int get hours => _hours;

  void addWorkout(Exercise workout) {
    workouts.add(workout);
    hasWorkout = true;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class PlanWorkoutScreen extends StatelessWidget {
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
                context.read<PlanWorkoutState>().addWorkout(selectedExercise);
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
                          return WorkoutWidget(
                            selectedExercise: workoutState.workouts[index],
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
              Consumer<PlanWorkoutState>(
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
                  onPressed: () {},
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
