import 'package:flutter/material.dart';
import './common/navigation/app_routes.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
