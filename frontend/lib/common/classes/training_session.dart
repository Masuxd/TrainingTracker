import 'package:frontend/common/classes/set.dart';

class TrainingSession {
  DateTime startTime;
  DateTime endTime;
  bool finished;
  List<Set> sets;

  TrainingSession({
    required this.startTime,
    required this.endTime,
    required this.finished,
    required this.sets,
  });

  Map<String, dynamic> toJson() {
    return {
      "start_time": startTime.toIso8601String(),
      "end_time": endTime.toIso8601String(),
      "finished": finished,
      "set": sets.map((set) => set.toJson()).toList(),
    };
  }

  factory TrainingSession.fromJson(Map<String, dynamic> json) {
    return TrainingSession(
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      finished: json['finished'],
      sets: (json['set'] as List).map((item) => Set.fromJson(item)).toList(),
    );
  }
}
