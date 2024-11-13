import 'exercise.dart';
import 'rep.dart';

class Set {
  final String id;
  Exercise exercise;
  List<Rep> rep;

  Set({
    required this.id,
    required this.exercise,
    required this.rep,
  });

  factory Set.fromJson(Map<String, dynamic> json) {
    return Set(
      id: json['id'],
      exercise: Exercise.fromJson(json['exercise']),
      rep: (json['rep'] as List).map((rep) => Rep.fromJson(rep)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exercise': exercise.toJson(),
      'rep': rep.map((rep) => rep.toJson()).toList(),
    };
  }
}
