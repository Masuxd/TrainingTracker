import 'package:flutter/material.dart';
import 'package:frontend/common/classes/training_plan.dart';
import 'package:frontend/common/classes/training_session.dart';
import 'package:provider/provider.dart';
import '../../common/widgets/layout_widget.dart';
//import '../../mock_data/mock_users.dart';
import '../../mock_data/mock_plans.dart';
import '../../start_workout.dart';
import '../../common/services/training_session_service.dart';

class TrainingTracker extends StatelessWidget {
  const TrainingTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeScreenState(),
      child: MainLayout(
        currentIndex: 0,
        child: HomeScreen(),
      ),
    );
  }
}

class HomeScreenState extends ChangeNotifier {
  //final user = mockUsers[0];
  //final plans = mockPlans.toList();
  Future<List<TrainingSession>?> plans = fetchWorkoutList();
  Future<int> getPlansLength() async {
    final plansList = await plans;
    return plansList?.length ?? 0;
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/start-workout');
              },
              child: Text('Start a Workout'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/plan-workout');
              },
              child: Text('Plan a workout'),
            ),
            SizedBox(height: 50),
            Expanded(
              child: FutureBuilder<int>(
                future: context.read<HomeScreenState>().getPlansLength(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child:
                            CircularProgressIndicator()); // Show loading spinner while waiting
                  } else if (snapshot.hasError) {
                    return Center(
                        child:
                            Text('Error: ${snapshot.error}')); // Handle errors
                  } else {
                    final length = snapshot.data ?? 0; // Get the length
                    return ListView.builder(
                      itemCount: length,
                      itemBuilder: (context, index) {
                        return FutureBuilder<List<TrainingSession>?>(
                          future: context.read<HomeScreenState>().plans,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else {
                              final plans = snapshot.data;
                              final session = plans?[index];
                              //debugPrint(session?.sessionId);
                              return ListTile(
                                title: Text('${session?.name}' ?? 'No Name'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          StartWorkout(session: session),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
