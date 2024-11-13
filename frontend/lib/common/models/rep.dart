class Rep {
  int repetitions;
  int weight;
  DateTime duration;
  double distance;
  double speed;

  Rep({
    required this.repetitions,
    required this.weight,
    required this.duration,
    required this.distance,
    required this.speed,
  });

  factory Rep.fromJson(Map<String, dynamic> json) {
    return Rep(
      repetitions: json['repetitions'],
      weight: json['weight'],
      duration: DateTime.parse(json['duration']),
      distance: json['distance'],
      speed: json['speed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'repetitions': repetitions,
      'weight': weight,
      'duration': duration.toIso8601String(),
      'distance': distance,
      'speed': speed,
    };
  }
}
