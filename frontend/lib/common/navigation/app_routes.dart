import 'package:flutter/material.dart';
import 'package:frontend/features/auth/login_screen.dart';
import '../../profile_screen.dart';
import '../../features/home/home_screen.dart';
import '../../calendar_screen.dart';
import '../../settings_screen.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => TrainingTracker());
      case '/calendar':
        return MaterialPageRoute(builder: (_) => CalendarScreenWrapper());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreenWrapper());
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsScreenWrapper());
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
