export 'rep.dart';

class Rep {
  int repetitions;
  int weight;
  int duration;
  double distance;
  double speed;
  bool finished;

  Rep({
    required this.repetitions,
    this.weight = 0,
    this.duration = 0,
    this.distance = 0.0,
    this.speed = 0.0,
    this.finished = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "repetitions": repetitions,
      "weight": weight,
      "duration": duration,
      "distance": distance,
      "speed": speed,
      "finished": finished,
    };
  }

  factory Rep.fromJson(Map<String, dynamic> json) {
    return Rep(
      repetitions: json['repetitions'],
      weight: (json['weight']),
      duration: (json['duration']),
      distance: (json['distance'] as num).toDouble(),
      speed: (json['speed'] as num).toDouble(),
      finished: json['finished'],
    );
  }
}
