import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/widgets/layout_widget.dart';

class ProfileScreenWrapper extends StatelessWidget {
  const ProfileScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileScreenState(),
      child: MainLayout(
        currentIndex: 2,
        child: ProfileScreen(),
      ),
    );
  }
}

class ProfileScreenState extends ChangeNotifier {}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('ProfileScreen built');
    return Center(
      child: Text('Profile Screen'),
    );
  }
}
