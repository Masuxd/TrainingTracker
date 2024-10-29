import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/widgets/layout_widget.dart';
import 'common/widgets/workout_widget.dart';
import 'common/widgets/select_workout.dart';

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
  bool hasWorkout = false;
  String? selectedWorkout;

  void setWorkout(String? workout) {
    selectedWorkout = workout;
    hasWorkout = true;
    notifyListeners();
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
                context.read<StartWorkoutState>().setWorkout(selectedWorkout);
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
                  ? WorkoutWidget(selectedWorkout: workoutState.selectedWorkout)
                  : Column(
                      children: [
                        SizedBox(height: 16),
                        Text('Add Exercises to your workout'),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }
}
