import 'package:flutter/material.dart';
import '../../mockExercises.dart';
import '../models/exercise.dart';

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
  late List<String> options;
  late List<String> filteredOptions;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    options = mockExercises.map((exercise) => exercise.name).toList();
    filteredOptions = List.from(options);
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      filteredOptions = options
          .where((option) => option
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
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
                  return ListTile(
                    title: Text(filteredOptions[index]),
                    onTap: () {
                      Navigator.pop(context, filteredOptions[index]);
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
