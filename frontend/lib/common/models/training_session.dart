import 'set.dart';

class TrainingSession {
  final String sessionId;
  final String userId;
  DateTime? startTime;
  DateTime? endTime;
  List<Set> sets;

  TrainingSession({
    required this.sessionId,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.sets,
  });

  factory TrainingSession.fromJson(Map<String, dynamic> json) {
    return TrainingSession(
      sessionId: json['id'],
      userId: json['userId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      sets: (json['sets'] as List).map((set) => Set.fromJson(set)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': sessionId,
      'userId': userId,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'sets': sets.map((set) => set.toJson()).toList(),
    };
  }
}
