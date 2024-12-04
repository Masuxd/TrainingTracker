import 'package:frontend/common/classes/rep.dart';
import 'package:frontend/common/classes/exercise.dart';

export 'set.dart';

class Set {
  final String setId;
  final Exercise exercise;
  //String exerciseId;
  int restTime;
  bool finished;
  List<Rep> rep;
  final String widgetId;

  Set({
    required this.setId,
    required this.exercise,
    //required this.exerciseId,
    required this.restTime,
    this.finished = false,
    required this.rep,
    required this.widgetId,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": setId,
      "exercise": exercise.toJson(),
      //"exercise": exerciseId,
      "recovery_time": restTime,
      "finished": finished,
      "rep": rep.map((rep) => rep.toJson()).toList(),
      "widgetId": widgetId,
    };
  }

  factory Set.fromJson(Map<String, dynamic> json) {
    return Set(
      setId: json['id'],
      exercise: Exercise.fromJson(json['exercise']),
      //exerciseId: json['exercise'],
      restTime: json['recovery_time'],
      finished: json['finished'],
      rep: (json['rep'] as List).map((item) => Rep.fromJson(item)).toList(),
      widgetId: json['widgetId'],
    );
  }
}
