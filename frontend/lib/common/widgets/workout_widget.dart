import 'package:flutter/material.dart';
import 'package:frontend/start_workout.dart';
import 'package:provider/provider.dart';
import '../models/exercise.dart';
import 'package:uuid/uuid.dart';
import '../models/set.dart' as model;

class WorkoutWidget extends StatefulWidget {
  final Exercise selectedExercise;
  final String widgetId;
  final VoidCallback onDelete;

  WorkoutWidget(
      {required this.selectedExercise,
      required this.widgetId,
      required this.onDelete});

  @override
  WorkoutWidgetState createState() => WorkoutWidgetState();
}

class WorkoutWidgetState extends State<WorkoutWidget> {
  @override
  void initState() {
    //final session = context.read<StartWorkoutState>().session!;
    super.initState();
    //debugPrint('Widget ID workout: ${widget.widgetId}');
    //debugPrint('Set ID workout: ${session.sets.last.setId}');
  }

  @override
  Widget build(BuildContext context) {
    final session = context.read<StartWorkoutState>().session!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          bottom: 16.0,
          left: 30.0,
          right: 30.0,
        ),
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
                    for (var set in session.sets)
                      if (set.exercise.name == widget.selectedExercise.name &&
                          set.widgetId == widget.widgetId)
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('Set:'),
                              ],
                            ),
                            SizedBox(height: 15),
                            Set(selectedExercise: widget.selectedExercise),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (session.sets
                                          .where((set) =>
                                              widget.widgetId == set.widgetId)
                                          .length >
                                      1)
                                    ElevatedButton(
                                      onPressed: () {
                                        session.sets.removeWhere((element) =>
                                            element.setId == set.setId);

                                        /*debugPrint(
                                            'List length: ${session.sets.length}');
                                        for (var set in session.sets) {
                                          debugPrint(
                                              'Set ID: ${set.setId}, Exercise: ${set.exercise.name}');
                                        }*/
                                      },
                                      child: Text('Delete Set'),
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                    ElevatedButton(
                      onPressed: () {
                        session.sets.add(model.Set(
                          setId: Uuid().v4(),
                          exercise: widget.selectedExercise,
                          rep: [],
                          widgetId: widget.widgetId,
                        ));
                        //debugPrint('New Set Added:');
                        //debugPrint('Set ID: ${session.sets.last.setId}');
                        //debugPrint('Widget ID: ${widget.widgetId}');
                        //debugPrint(
                        //  'Session Sets Length: ${session.sets.length}');
                        setState(() {});
                      },
                      child: Text('Add Set +'),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            session.sets.removeWhere((set) =>
                                set.exercise.name ==
                                    widget.selectedExercise.name &&
                                set.widgetId == widget.widgetId);

                            /*debugPrint('List length: ${session.sets.length}');
                            for (var set in session.sets) {
                              debugPrint(
                                  'Widget ID: ${widget.widgetId}, Set ID: ${set.setId}, Exercise: ${set.exercise.name}');
                            }*/
                            widget.onDelete();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Text('Delete Exercise'),
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
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
    ]);
  }
}
