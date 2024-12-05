import 'package:frontend/common/classes/rep.dart';

export 'set.dart';

class Set {
  final String setId;
  //final Exercise exercise;
  String exerciseId;
  int restTime;
  bool finished;
  List<Rep> rep;
  final String widgetId;

  Set({
    required this.setId,
    //required this.exercise,
    required this.exerciseId,
    required this.restTime,
    this.finished = false,
    required this.rep,
    required this.widgetId,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": setId,
      "exercise": exerciseId,
      "recovery_time": restTime,
      "finished": finished,
      "rep": rep.map((rep) => rep.toJson()).toList(),
      "widget_id": widgetId,
    };
  }

  factory Set.fromJson(Map<String, dynamic> json) {
    return Set(
      setId: json['_id'],
      //exercise: Exercise.fromJson(json['exercise']),
      exerciseId: json['exercise'],
      restTime: json['recovery_time'],
      finished: json['finished'],
      widgetId: json['widget_id'],
      rep: (json['rep'] as List).map((item) => Rep.fromJson(item)).toList(),
    );
  }
}
