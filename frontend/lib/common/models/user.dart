import 'training_session.dart';
import 'training_plan.dart';

class User {
  final String id;
  String username;
  String email;
  String password;
  String firstName;
  String lastName;
  DateTime birthDate;
  String phone;
  List<TrainingSession> trainingSessions;
  List<TrainingPlan> trainingPlans;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.phone,
    required this.trainingSessions,
    required this.trainingPlans,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthDate: DateTime.parse(json['birthDate']),
      phone: json['phone'],
      trainingSessions: (json['trainingSessions'] as List)
          .map((session) => TrainingSession.fromJson(session))
          .toList(),
      trainingPlans: (json['trainingPlans'] as List)
          .map((plan) => TrainingPlan.fromJson(plan))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate.toIso8601String(),
      'phone': phone,
      'trainingSessions':
          trainingSessions.map((session) => session.toJson()).toList(),
      'trainingPlans': trainingPlans.map((plan) => plan.toJson()).toList(),
    };
  }
}
