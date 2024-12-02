export 'rep.dart';

class Rep {
  int repetitions;
  double weight;
  DateTime duration;
  double distance;
  double speed;
  bool finished;

  Rep({
    required this.repetitions,
    this.weight = 0.0,
    DateTime? duration,
    this.distance = 0.0,
    this.speed = 0.0,
    this.finished = false,
  }) : duration = duration ?? DateTime(1970, 1, 1);

  Map<String, dynamic> toJson() {
    return {
      "repetitions": repetitions,
      "weight": weight,
      "duration": duration.toIso8601String(),
      "distance": distance,
      "speed": speed,
      "finished": finished,
    };
  }

  factory Rep.fromJson(Map<String, dynamic> json) {
    return Rep(
      repetitions: json['repetitions'],
      weight: (json['weight'] as num).toDouble(),
      duration: DateTime.parse(json['duration']),
      distance: (json['distance'] as num).toDouble(),
      speed: (json['speed'] as num).toDouble(),
      finished: json['finished'],
    );
  }
}
