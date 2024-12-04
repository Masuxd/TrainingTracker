import 'package:uuid/uuid.dart';
import '../common/classes/training_session.dart';
import '../common/classes/exercise.dart';
import '../common/classes/set.dart';
import '../common/classes/rep.dart';

final mockPlans = [
  TrainingSession(
    sessionId: Uuid().v4(),
    name: 'Plan 1',
    isPlan: true,
    startTime: DateTime.now(),
    endTime: DateTime.now().add(Duration(hours: 1)),
    finished: true,
    sets: [
      Set(
        setId: Uuid().v4(),
        exercise: Exercise(
            exerciseId: 'nynbcfg',
            name: 'Push Up',
            weight: false,
            distance: false,
            duration: false,
            speed: false),
        restTime: 60,
        rep: [
          Rep(
            repetitions: 10,
            weight: 0,
            duration: 0,
            distance: 0.0,
            speed: 0.0,
            finished: true,
          )
        ],
        widgetId: Uuid().v4(),
      ),
      Set(
        setId: Uuid().v4(),
        exercise: Exercise(
          exerciseId: 'rbvxfhbh',
          name: 'Barbell Curll',
          weight: true,
          distance: false,
          duration: false,
          speed: false,
        ),
        restTime: 30,
        rep: [
          Rep(
            repetitions: 10,
            weight: 10,
            duration: 0,
            distance: 0.0,
            speed: 0.0,
          ),
        ],
        widgetId: Uuid().v4(),
      ),
    ],
  ),
  TrainingSession(
    sessionId: Uuid().v4(),
    name: 'Plan 2',
    isPlan: true,
    startTime: DateTime.now(),
    endTime: DateTime.now().add(Duration(hours: 1)),
    finished: true,
    sets: [
      Set(
        setId: Uuid().v4(),
        exercise: Exercise(
            exerciseId: 'nynbcfg',
            name: 'Push Up',
            weight: false,
            distance: false,
            duration: false,
            speed: false),
        restTime: 60,
        rep: [
          Rep(
            repetitions: 10,
            weight: 0,
            duration: 0,
            distance: 0.0,
            speed: 0.0,
            finished: true,
          )
        ],
        widgetId: Uuid().v4(),
      ),
      Set(
        setId: Uuid().v4(),
        exercise: Exercise(
          exerciseId: 'rbvxfhbh',
          name: 'Barbell Curll',
          weight: true,
          distance: false,
          duration: false,
          speed: false,
        ),
        restTime: 30,
        rep: [
          Rep(
            repetitions: 10,
            weight: 10,
            duration: 0,
            distance: 0.0,
            speed: 0.0,
          ),
        ],
        widgetId: Uuid().v4(),
      ),
    ],
  ),
];
