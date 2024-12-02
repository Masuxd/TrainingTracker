import 'package:frontend/common/classes/rep.dart';

export 'set.dart';

class Set {
  String exerciseId;
  DateTime recoveryTime;
  bool finished;
  List<Rep> reps;

  Set({
    required this.exerciseId,
    required this.recoveryTime,
    this.finished = false,
    required this.reps,
  });

  Map<String, dynamic> toJson() {
    return {
      "exercise": exerciseId,
      "recovery_time": recoveryTime.toIso8601String(),
      "finished": finished,
      "rep": reps.map((rep) => rep.toJson()).toList(),
    };
  }

  factory Set.fromJson(Map<String, dynamic> json) {
    return Set(
      exerciseId: json['exercise'],
      recoveryTime: DateTime.parse(json['recovery_time']),
      finished: json['finished'],
      reps: (json['rep'] as List).map((item) => Rep.fromJson(item)).toList(),
    );
  }
}
