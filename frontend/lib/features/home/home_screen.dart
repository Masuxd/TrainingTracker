import 'package:flutter/material.dart';
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
  final plans = mockPlans.toList();
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
              child: ListView.builder(
                  itemCount: context.read<HomeScreenState>().plans.length,
                  itemBuilder: (context, index) {
                    final session = mockPlans[index];
                    return ListTile(
                      title: Text('${session.name}'),
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
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
