import 'exercise.dart';
import 'rep.dart';

class Set {
  final String setId;
  final Exercise exercise;
  List<Rep> rep;
  final String widgetId;

  Set({
    required this.setId,
    required this.exercise,
    required this.rep,
    required this.widgetId,
  });

  factory Set.fromJson(Map<String, dynamic> json) {
    return Set(
      setId: json['id'],
      exercise: Exercise.fromJson(json['exercise']),
      rep: (json['rep'] as List).map((rep) => Rep.fromJson(rep)).toList(),
      widgetId: json['widgetId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': setId,
      'exercise': exercise.toJson(),
      'rep': rep.map((rep) => rep.toJson()).toList(),
      'widgetId': widgetId,
    };
  }
}
