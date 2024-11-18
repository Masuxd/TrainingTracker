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
  List<Exercise> workouts = [];
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
    workouts.add(workout);
    hasWorkout = true;
    session?.sets.add(model.Set(
      setId: Uuid().v4(),
      exercise: workout,
      rep: [],
      widgetId: Uuid().v4(),
    ));
    debugPrint('Widget ID start: ${session!.sets.last.widgetId}');
    debugPrint('Set ID start: ${session!.sets.last.setId}');
    debugPrint('Adding workout: ${workout.name}');
    notifyListeners();
  }

  void removeWorkout(int index) {
    workouts.removeAt(index);
    notifyListeners();
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
                          return WorkoutWidget(
                              selectedExercise: workoutState.workouts[index],
                              widgetId:
                                  workoutState.session!.sets[index].widgetId,
                              onDelete: () {
                                context
                                    .read<StartWorkoutState>()
                                    .removeWorkout(index);
                              });
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
