import 'package:flutter/material.dart';
//import 'package:frontend/theme.dart';
import 'package:provider/provider.dart';
import './common/navigation/app_routes.dart';
import 'theme_provider.dart';
//import './features/home/home_screen.dart';


void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: Main(),
  )
  );
}

class Main extends StatelessWidget {
  const Main({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: AppRoutes.generateRoute,
      theme: Provider.of<ThemeProvider>(context).themeData,
      //home: TrainingTracker(),
    );
  }
}
