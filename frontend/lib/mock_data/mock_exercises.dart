import '../common/models/exercise.dart';

// 'Name', 'Weight', 'Distance', 'Time'

List<Exercise> mockExercises = [
  Exercise(
    name: 'Barbell Curl',
    isWeight: true,
    isDistance: false,
    isTime: false,
  ),
  Exercise(
    name: 'Treadmill',
    isWeight: false,
    isDistance: true,
    isTime: true,
  ),
  Exercise(
    name: 'Rowing Machine',
    isWeight: false,
    isDistance: true,
    isTime: true,
  ),
];
