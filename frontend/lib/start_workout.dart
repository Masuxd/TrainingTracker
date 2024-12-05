import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/widgets/layout_widget.dart';
import 'common/widgets/workout_widget.dart';
import 'common/widgets/select_workout.dart';
import './common/classes/exercise.dart';
import './common/classes/training_session.dart';
import 'dart:async';
import 'package:uuid/uuid.dart';
import 'common/classes/set.dart' as model;
import './common/services/training_session_service.dart';
import './common/services/exercise_service.dart';

class StartWorkout extends StatelessWidget {
  //const StartWorkout({super.key});
  final TrainingSession? session;
  const StartWorkout({this.session});

  @override
  Widget build(BuildContext context) {
    //final mockUser = mockUsers[0];
    TrainingSession workoutSession;

    workoutSession = session ??
        TrainingSession(
          sessionId: Uuid().v4(),
          name: 'Workout',
          isPlan: false,
          startTime: DateTime.now(),
          endTime: null,
          finished: false,
          sets: [],
        );
    //debugPrint('Start workout SessionId: ${session?.sessionId}');
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
  bool initialPlanStatus = false;
  late Timer _timer;
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;

  bool hasWorkout = false;
  List<Map<String, dynamic>> workouts = [];

  Future<void> startSession() async {
    //debugPrint('Aloitus');
    //debugPrint('SessionId startSession(): ${session!.sessionId}');
    if (session?.sets != null) {
      hasWorkout = true;

      for (var set in session!.sets) {
        //debugPrint('exerciseId startSession(): ${set.exerciseId}');
        Exercise? exercise =
            await fetchExercise(set.exerciseId); // Await the result
        //debugPrint('Exercise ID StartSession(): ${exercise?.exerciseId}');
        if (exercise != null) {
          //hasWorkout = true;
          //debugPrint('Exercise ID StartSession(): ${exercise.exerciseId}');
          workouts.add({
            'workoutId': exercise.exerciseId,
            'widgetId': set.widgetId,
          });
          //debugPrint('Lisäys');
          notifyListeners();
        }
      }
    }
    //debugPrint('hasWorkout startSession(): $hasWorkout');
    //final mockUser = mockUsers[0];
    final sessionId = Uuid().v4();
    session = session ??
        TrainingSession(
          sessionId: sessionId,
          name: 'Workout',
          isPlan: false,
          startTime: DateTime.now(),
          endTime: null,
          finished: false,
          sets: [],
        );

    /*if (workouts.isNotEmpty) {
      debugPrint("tättärää");
      hasWorkout = true;
    }*/

    //debugPrint('Session start time: ${session!.sessionId}');
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
    _initialize();
  }

  Future<void> _initialize() async {
    await startSession();
    if (session?.isPlan == true) {
      initialPlanStatus = true;
    }
  }

  int get seconds => _seconds;
  int get minutes => _minutes;
  int get hours => _hours;

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

  Future<void> saveSession(BuildContext context) async {
    if (session == null || session!.sets.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No workout to save.'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    if (initialPlanStatus) {
      session?.isPlan = false;
    }

    session?.endTime = DateTime.now();

    postWorkout(session!);

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
  //const StartWorkoutScreen({super.key, this.session});
  @override
  Widget build(BuildContext context) {
    //final session = context.read<StartWorkoutState>().session;

    //debugPrint('StartWorkoutScreen SessionId: ${session?.sessionId}');
    //debugPrint('legth StartWorkoutScreen: ${session?.sets.length}');
    //debugPrint(
    //  'hasWorkout screen: ${context.watch<StartWorkoutState>().hasWorkout}');
    //debugPrint(
    //  'Workouts List: ${context.watch<StartWorkoutState>().workouts.toString()}');
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
                    String? selectedWorkoutId =
                        await selectWorkout.show(context);
                    //debugPrint('selectWorkout: $selectedWorkoutId');
                    if (selectedWorkoutId != null) {
                      context
                          .read<StartWorkoutState>()
                          .addWorkout(selectedWorkoutId);
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
