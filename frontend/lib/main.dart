import 'package:flutter/material.dart';
import 'package:frontend/features/auth/login_screen.dart';
import 'package:frontend/features/home/home_screen.dart';
//import 'package:frontend/theme.dart';
import 'package:provider/provider.dart';
import './common/navigation/app_routes.dart';
import './http_overrides.dart';
import 'dart:io';
import 'theme_provider.dart';
//import './features/home/home_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: Main(),
  ));
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {'/login': (context) => LoginScreen()},
      onGenerateRoute: AppRoutes.generateRoute,
      theme: Provider.of<ThemeProvider>(context).themeData,
      //home: TrainingTracker(),
    );
  }
}
