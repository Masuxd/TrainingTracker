import 'package:frontend/common/classes/set.dart';

class TrainingSession {
  final String sessionId;
  String name;
  bool isPlan;
  DateTime? startTime;
  DateTime? endTime;
  bool finished;
  List<Set> sets;

  TrainingSession({
    required this.sessionId,
    required this.name,
    required this.isPlan,
    required this.startTime,
    required this.endTime,
    required this.finished,
    required this.sets,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": sessionId,
      "name": name,
      "is_plan": isPlan,
      "start_time": startTime?.toIso8601String(),
      "end_time": endTime?.toIso8601String(),
      "finished": finished,
      "set": sets.map((set) => set.toJson()).toList(),
    };
  }

  factory TrainingSession.fromJson(Map<String, dynamic> json) {
    return TrainingSession(
      sessionId: json['_id'],
      name: json['name'],
      isPlan: json['is_plan'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      finished: json['finished'],
      sets: (json['set'] as List).map((item) => Set.fromJson(item)).toList(),
    );
  }
}
