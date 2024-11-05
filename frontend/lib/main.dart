import 'package:flutter/material.dart';
import './common/navigation/app_routes.dart';
import './http_overrides.dart';
import 'dart:io';
//import './features/home/home_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: AppRoutes.generateRoute,
      //home: TrainingTracker(),
    );
  }
}
