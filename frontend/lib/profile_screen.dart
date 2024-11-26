import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'common/widgets/layout_widget.dart';


class ProfileScreenWrapper extends StatelessWidget {
  const ProfileScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileScreenState(),
      child: MainLayout(
        currentIndex: 2,
        child: const ProfileScreen(),
      )
    );
  }
}

class ProfileScreenState extends ChangeNotifier {
  String? _imagePath;

  String? get imagePath => _imagePath;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imagePath = pickedFile.path;
      notifyListeners();
    }
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<ProfileScreenState>();


    final currentUser = 'Your Username'; // Korvaa tämä muuttujalla

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profile image
            GestureDetector(
              onTap: () => context.read<ProfileScreenState>().pickImage(),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                backgroundImage: profileState.imagePath != null
                    ? FileImage(File(profileState.imagePath!))
                    : null,
                child: profileState.imagePath == null
                    ? const Icon(
                        Icons.add_a_photo,
                        size: 30,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              currentUser,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
    );
  }
}
