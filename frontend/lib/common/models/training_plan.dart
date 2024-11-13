import 'set.dart';

class TrainingPlan {
  final String id;
  final String userId;
  DateTime startTime;
  DateTime endTime;
  List<Set> sets;

  TrainingPlan({
    required this.id,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.sets,
  });

  factory TrainingPlan.fromJson(Map<String, dynamic> json) {
    return TrainingPlan(
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
      'endTime': endTime.toIso8601String(),
      'sets': sets.map((set) => set.toJson()).toList(),
    };
  }
}
