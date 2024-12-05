import 'package:flutter/material.dart';
import 'package:frontend/common/classes/training_session.dart';
import '../classes/exercise.dart';
import 'package:uuid/uuid.dart';
import '../classes/set.dart' as model;
import '../classes/rep.dart';

class WorkoutWidget extends StatefulWidget {
  final Exercise selectedExercise;
  final TrainingSession session;
  final String widgetId;
  final VoidCallback onDelete;

  WorkoutWidget(
      {required this.selectedExercise,
      required this.session,
      required this.widgetId,
      required this.onDelete});

  @override
  WorkoutWidgetState createState() => WorkoutWidgetState();
}

class WorkoutWidgetState extends State<WorkoutWidget> {
  void updateReps(int index, Rep rep) {
    widget.session.sets[index].rep.add(rep);
  }

  @override
  Widget build(BuildContext context) {
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
                    for (var set in widget.session.sets)
                      if (set.widgetId == widget.widgetId)
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('Set:'),
                              ],
                            ),
                            SizedBox(height: 15),
                            Set(
                                selectedExercise: widget.selectedExercise,
                                session: widget.session,
                                setId: set.setId,
                                widgetId: widget.widgetId),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (widget.session.sets
                                          .where((set) =>
                                              widget.widgetId == set.widgetId)
                                          .length >
                                      1)
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          widget.session.sets.removeWhere(
                                              (element) =>
                                                  element.setId == set.setId);
                                        });
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
                        widget.session.sets.add(model.Set(
                          setId: Uuid().v4(),
                          exerciseId: widget.selectedExercise.exerciseId,
                          rep: [],
                          widgetId: widget.widgetId,
                          restTime: 0,
                        ));
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
                            widget.session.sets.removeWhere(
                                (set) => set.widgetId == widget.widgetId);
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
  final TrainingSession session;
  final String setId;
  final String widgetId;
  Set(
      {required this.selectedExercise,
      required this.session,
      required this.setId,
      required this.widgetId});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      if (selectedExercise.weight)
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
                  onChanged: (value) {
                    for (var set in session.sets) {
                      if (set.widgetId == widgetId && set.setId == setId) {
                        if (set.rep.isNotEmpty) {
                          set.rep.last.weight =
                              int.tryParse(value) ?? set.rep.last.weight;
                        } else {
                          set.rep.add(Rep(
                            repetitions: 0,
                            weight: int.tryParse(value) ?? 0,
                            duration: 0,
                            distance: 0.0,
                            speed: 0.0,
                          ));
                        }
                      }
                    }
                  },
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Reps: ',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    for (var set in session.sets) {
                      if (set.widgetId == widgetId && set.setId == setId) {
                        if (set.rep.isNotEmpty) {
                          set.rep.last.repetitions =
                              int.tryParse(value) ?? set.rep.last.repetitions;
                        } else {
                          set.rep.add(Rep(
                            repetitions: int.tryParse(value) ?? 0,
                            weight: 0,
                            duration: 0,
                            distance: 0.0,
                            speed: 0.0,
                          ));
                        }
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      if (selectedExercise.distance)
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Distance: (km)',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              for (var set in session.sets) {
                if (set.widgetId == widgetId && set.setId == setId) {
                  if (set.rep.isNotEmpty) {
                    set.rep.last.distance =
                        double.tryParse(value) ?? set.rep.last.distance;
                  } else {
                    set.rep.add(Rep(
                      repetitions: 0,
                      weight: 0,
                      duration: 0,
                      distance: double.tryParse(value) ?? 0.0,
                      speed: 0.0,
                    ));
                  }
                }
              }
            },
          ),
        ),
      if (selectedExercise.duration)
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Time: (s)',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              for (var set in session.sets) {
                if (set.widgetId == widgetId && set.setId == setId) {
                  if (set.rep.isNotEmpty) {
                    set.rep.last.duration =
                        int.tryParse(value) ?? set.rep.last.duration;
                  } else {
                    set.rep.add(Rep(
                      repetitions: 0,
                      weight: 0,
                      duration: 0,
                      distance: 0.0,
                      speed: 0.0,
                    ));
                  }
                }
              }
            },
          ),
        ),
      TextField(
        decoration: InputDecoration(
          labelText: 'Enter Rest Time (s)',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          for (var set in session.sets) {
            if (set.widgetId == widgetId && set.setId == setId) {
              set.restTime = int.tryParse(value) ?? set.restTime;
            }
          }
        },
      ),
    ]);
  }
}
