class Exercise {
  final String name;
  bool isWeight = false;
  bool isDistance = false;
  bool isTime = false;

  Exercise({
    required this.name,
    required this.isWeight,
    required this.isDistance,
    required this.isTime,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      isWeight: json['isWeight'],
      isDistance: json['isDistance'],
      isTime: json['isTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isWeight': isWeight,
      'isDistance': isDistance,
      'isTime': isTime,
    };
  }
}
