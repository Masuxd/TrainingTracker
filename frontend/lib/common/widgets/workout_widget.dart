import 'package:flutter/material.dart';
import '../../mockExercises.dart';
import '../models/exercise.dart';

class WorkoutWidget extends StatefulWidget {
  final Exercise selectedExercise;
  WorkoutWidget({required this.selectedExercise});

  @override
  _WorkoutWidgetState createState() => _WorkoutWidgetState();
}

class _WorkoutWidgetState extends State<WorkoutWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: Text(widget.selectedExercise.name),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Set(selectedExercise: widget.selectedExercise),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle Save action
                          },
                          child: Text('Save'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle Cancel action
                          },
                          child: Text('Cancel'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Set extends StatelessWidget {
  final Exercise selectedExercise;
  Set({required this.selectedExercise});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text('Set:'),
          ],
        ),
        SizedBox(height: 15),
        if (selectedExercise.isWeight)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Weight: (kg)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Reps: (s)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (selectedExercise.isDistance)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Distance: (km)',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        if (selectedExercise.isTime)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Time: (s)',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Enter Rest Time',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
