export 'exercise.dart';

class Exercise {
  String exerciseId;
  String name;
  bool weight;
  bool distance;
  bool duration;
  bool speed;

  Exercise({
    required this.exerciseId,
    required this.name,
    this.weight = false,
    this.distance = false,
    this.duration = false,
    this.speed = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": exerciseId,
      "name": name,
      "weight": weight,
      "distance": distance,
      "duration": duration,
      "speed": speed,
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
        exerciseId: json['_id'],
        name: json['name'],
        weight: json['weight'],
        distance: json['distance'],
        duration: json['duration'],
        speed: json['speed']);
  }
}

 /*
  name: String,
  weight: Boolean,
  distance: Boolean,
  duration: Boolean,
  speed: Boolean,  name: String,
  weight: Boolean,
  distance: Boolean,
  duration: Boolean,
  speed: Boolean,
*/