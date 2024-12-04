import 'package:uuid/uuid.dart';
import '../common/models/training_session.dart';
import '../common/models/exercise.dart';
import '../common/models/set.dart';
import '../common/models/rep.dart';

final mockPlans = [
  TrainingSession(
    sessionId: Uuid().v4(),
    name: 'Plan 1',
    isPlan: true,
    userId: '1',
    startTime: DateTime.now(),
    endTime: DateTime.now().add(Duration(hours: 1)),
    sets: [
      Set(
        setId: Uuid().v4(),
        exercise: Exercise(
            name: 'Push Up', isWeight: false, isDistance: false, isTime: false),
        rep: [
          Rep(
              repetitions: 10,
              weight: 0,
              duration: 0,
              distance: 0.0,
              speed: 0.0)
        ],
        widgetId: Uuid().v4(),
        restTime: 60,
      ),
      Set(
        setId: Uuid().v4(),
        exercise: Exercise(
            name: 'Barbell Curll',
            isWeight: true,
            isDistance: false,
            isTime: false),
        rep: [
          Rep(
              repetitions: 10,
              weight: 10,
              duration: 0,
              distance: 0.0,
              speed: 0.0)
        ],
        widgetId: Uuid().v4(),
        restTime: 30,
      ),
    ],
  ),
  TrainingSession(
    sessionId: Uuid().v4(),
    name: 'Plan 2',
    isPlan: true,
    userId: '1',
    startTime: DateTime.now(),
    endTime: DateTime.now().add(Duration(hours: 1)),
    sets: [
      Set(
        setId: Uuid().v4(),
        exercise: Exercise(
            name: 'Push Up', isWeight: false, isDistance: false, isTime: false),
        rep: [
          Rep(
              repetitions: 10,
              weight: 0,
              duration: 0,
              distance: 0.0,
              speed: 0.0)
        ],
        widgetId: Uuid().v4(),
        restTime: 60,
      ),
      Set(
        setId: Uuid().v4(),
        exercise: Exercise(
            name: 'Barbell Curll',
            isWeight: true,
            isDistance: false,
            isTime: false),
        rep: [
          Rep(
              repetitions: 10,
              weight: 10,
              duration: 0,
              distance: 0.0,
              speed: 0.0)
        ],
        widgetId: Uuid().v4(),
        restTime: 30,
      ),
    ],
  ),
];
