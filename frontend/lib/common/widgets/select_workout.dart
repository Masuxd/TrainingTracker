import 'package:flutter/material.dart';
import 'package:frontend/common/classes/exercise.dart';
import '../services/exercise_service.dart';

class SelectWorkout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SelectWorkoutState();

  Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => this,
    );
  }
}

class _SelectWorkoutState extends State<SelectWorkout> {
  late Future<List<Exercise>?> exercises;
  List<Exercise> options = [];
  List<Exercise> filteredOptions = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchExerciseList();
    searchController.addListener(_onSearchChanged);
  }

  Future<void> _fetchExerciseList() async {
    final exercisesList = await fetchExercises();
    setState(() {
      options = exercisesList ?? [];
      filteredOptions = options;
    });
    //debugPrint(options.toString());
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredOptions = options
          .where((option) => option.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        height: 400,
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredOptions.length,
                itemBuilder: (context, index) {
                  final exercise = filteredOptions[index];
                  return ListTile(
                    title: Text(exercise.name),
                    onTap: () {
                      //debugPrint('Selected: ${exercise.name}');
                      Navigator.pop(context, exercise.exerciseId);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
