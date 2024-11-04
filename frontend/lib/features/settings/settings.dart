/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Page',
      theme: ThemeData.light(), // Set a light theme
      home: const SettingsPage(), // Set the home page
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool valNotify1 = false;
  bool valNotify2 = false;
  bool valNotify3 = false;

  void onChangeFunction1(bool newValue1) {
    setState(() {
      valNotify1 = newValue1;
    });
  }

  void onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  void onChangeFunction3(bool newValue3) {
    setState(() {
      valNotify3 = newValue3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontSize: 33)), // Add title to AppBar
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  Icons.settings,
                ),
                SizedBox(width: 20),
                Text(
                  "Settings",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 20,
              thickness: 2,
            ),
            SizedBox(height: 10),
            buildNotificationOption("Theme dark", valNotify1, onChangeFunction1),
            buildNotificationOption("Screen lock", valNotify2, onChangeFunction2),
            buildNotificationOption("Unit of measure", valNotify3, onChangeFunction3),
          ],
        ),
      ),
    );
  }

  Padding buildNotificationOption(String title, bool value, Function onChangedMethod) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          Transform.scale(
            scale: 1.5,
            child: CupertinoSwitch(
              activeColor: Colors.green,
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue) {
                onChangedMethod(newValue);
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/features/settings/theme_provider.dart';
import 'package:frontend/features/settings/theme.dart';
import 'package:frontend/features/settings/button.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Settings Page',
          theme: themeProvider.themeData, // Use themeProvider to access themeData
          home: const SettingsPage(), // Set the home page
        );
      },
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool valNotify2 = false; // Screen lock
  bool valNotify3 = false; // Unit of measure

  void onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  void onChangeFunction3(bool newValue3) {
    setState(() {
      valNotify3 = newValue3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontSize: 33)),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.settings),
                SizedBox(width: 20),
                Text(
                  "Settings",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 20,
              thickness: 2,
            ),
            SizedBox(height: 10),
            buildNotificationOption(
              "Change to dark theme",
              context,
              true, // For the theme switch, we pass `true` to indicate it uses the theme provider
            ),
            buildNotificationOption("Screen lock", context, false, onChangeFunction2, valNotify2),
            buildNotificationOption("Unit of measure", context, false, onChangeFunction3, valNotify3),
          ],
        ),
      ),
    );
  }

  Padding buildNotificationOption(
      String title, BuildContext context, bool isThemeSwitch, [Function? onChangedMethod, bool? value]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          Transform.scale(
            scale: 1.5,
            child: CupertinoSwitch(
              activeColor: Colors.green,
              trackColor: Colors.grey,
              value: isThemeSwitch ? Provider.of<ThemeProvider>(context).themeData == darkMode : value ?? false,
              onChanged: (bool newValue) {
                if (isThemeSwitch) {
                  Provider.of<ThemeProvider>(context, listen: false).toggleTheme(); // Call toggleTheme for theme switch
                } else if (onChangedMethod != null) {
                  onChangedMethod(newValue); // Call the specific function for other switches
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
