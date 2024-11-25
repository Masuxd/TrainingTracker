import 'package:flutter/material.dart';
import 'package:frontend/theme.dart';
import 'package:provider/provider.dart';
import 'common/widgets/layout_widget.dart';
import 'theme_provider.dart';
import 'package:flutter/cupertino.dart';

class SettingsScreenWrapper extends StatelessWidget {
  const SettingsScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsScreenState(),
      child: MainLayout(
        currentIndex: 3,
        child: const SettingsScreen(),
      ),
    );
  }
}

class SettingsScreenState extends ChangeNotifier {}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
@override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsScreen> {

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
              true,
            ),
            buildNotificationOption(
                "Screen lock", context, false, onChangeFunction2, valNotify2),
            buildNotificationOption("Unit of measure", context, false,
                onChangeFunction3, valNotify3),
                SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Increase padding
                    textStyle: const TextStyle(fontSize: 20), // Increase font size
                    minimumSize: Size(200, 60), // Set a minimum size (width x height)
                  ),
                    child: Text(
                    'Sign out',
                  ),

                    ),
                )
          ],
        ),
      ),
    );
  }

  Padding buildNotificationOption(
      String title, BuildContext context, bool isThemeSwitch,
      [Function? onChangedMethod, bool? value]) {
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
              value: isThemeSwitch
                  ? Provider.of<ThemeProvider>(context).themeData == darkMode
                  : value ?? false,
              onChanged: (bool newValue) {
                if (isThemeSwitch) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(); // Call toggleTheme for theme switch
                } else if (onChangedMethod != null) {
                  onChangedMethod(
                      newValue); // Call the specific function for other switches
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}