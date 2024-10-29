import 'package:flutter/material.dart';
import 'package:frontend/features/auth/login_screen.dart';
import 'package:frontend/plan_workout.dart';
import 'package:frontend/start_workout.dart';
import '../../profile_screen.dart';
import '../../features/home/home_screen.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => TrainingTracker());
      case '/profile':
        return MaterialPageRoute(builder: (_) => TrainingProfile());
      case '/start-workout':
        return MaterialPageRoute(builder: (_) => StartWorkout());
      case '/plan-workout':
        return MaterialPageRoute(builder: (_) => PlanWorkout());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
