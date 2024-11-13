import 'set.dart';
import 'user.dart';

class TrainingSession {
  final String id;
  final String userId;
  DateTime startTime;
  DateTime? endTime;
  List<Set> sets;

  TrainingSession({
    required this.id,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.sets,
  });

  factory TrainingSession.fromJson(Map<String, dynamic> json) {
    return TrainingSession(
      id: json['id'],
      userId: json['userId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      sets: (json['sets'] as List).map((set) => Set.fromJson(set)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'sets': sets.map((set) => set.toJson()).toList(),
    };
  }
}
