import 'package:flutter/material.dart';
import './nav_bar.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final int currentIndex;

  MainLayout({required this.child, required this.currentIndex});

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  /*@override
  Widget build(BuildContext context) {
    debugPrint('Current child: ${widget.child.runtimeType}');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: widget.child,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: NavBar(
            currentIndex: widget.currentIndex,
            onTap: _onItemTapped,
          ),
        ),
      ],
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child, // Main content takes up the rest of the screen
      bottomNavigationBar: NavBar(
        currentIndex: widget.currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
