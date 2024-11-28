import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/exercise_mockdata.dart';
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
      ),
    );
  }
}

class ProfileScreenState extends ChangeNotifier {
  String? _imagePath;
  String? get imagePath => _imagePath;

  // Bio variables
  final TextEditingController _bioController = TextEditingController();
  String _savedBio = '';

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imagePath = pickedFile.path;
      notifyListeners();
    }
  }

  // Save bio function
  void saveBio(BuildContext context) {
    String newBio = _bioController.text;
    List<String> words = newBio.split(' ');

    if (words.length <= 200) {
      _savedBio = newBio;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bio saved successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bio cannot exceed 200 words!')),
      );
    }
  }

  String get savedBio => _savedBio;
  TextEditingController get bioController => _bioController;
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<ProfileScreenState>();
    final currentUser = 'Firstname Lastname'; // Replace this

    // Workout summary laskut
    final int totalWorkouts = mockWorkouts.length;
    final int totalTime = mockWorkouts.fold(
        0, (sum, workout) => sum + (workout['duration'] as int));

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

          // Username Section
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Username',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 25),
                Text(
                  currentUser,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                //Bio Section
                //Text(
                //'Bio',
                //style: TextStyle(color: Colors.grey[600]),
                //),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Bio Icon Button
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bio', style: TextStyle(color: Colors.grey[600])),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Edit Bio'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: profileState.bioController,
                                maxLines: 5,
                                maxLength: 200,
                                decoration: InputDecoration(
                                  labelText: 'Write your bio...',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                    context); // Close the dialog without saving
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                profileState.saveBio(context); // Save the bio
                                Navigator.pop(context);
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon:
                      const Icon(Icons.settings, color: Colors.grey, size: 30),
                  tooltip: 'Edit Bio', // for hoovering
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child:
                // Display Bio
                Text(
              profileState.savedBio.isEmpty
                  ? 'No bio added yet...'
                  : profileState.savedBio, // Display saved bio
            ),
          ),

          const SizedBox(height: 50),

          // Workout Summary
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Workout Summary',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          const SizedBox(height: 10),
          DataTable(
            columns: const [
              DataColumn(label: Text('  Total Workouts')),
              DataColumn(label: Text('  Total Time (min)')),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('           $totalWorkouts')),
                DataCell(Text('           $totalTime')),
              ]),
            ],
          ),

          const SizedBox(height: 20),

          // Workout Details
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Workout History',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),

          const SizedBox(height: 10),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mockWorkouts.length,
            itemBuilder: (context, index) {
              final workout = mockWorkouts[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                title: Text(workout['name']),
                subtitle: Text('Duration: ${workout['duration']} min'),
              );
            },
          ),
        ],
      ),
    );
  }
}
