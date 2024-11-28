import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/widgets/layout_widget.dart';

class SettingsScreenWrapper extends StatelessWidget {
  const SettingsScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsScreenState(),
      child: MainLayout(
        currentIndex: 3,
        child: SettingsScreen(),
      ),
    );
  }
}

class SettingsScreenState extends ChangeNotifier {}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('SettingsScreen built');
    return Center(
      child: Text('Settings Screen'),
    );
  }
}
