import '../common/models/user.dart';

List<User> mockUsers = [
  User(
    id: '1',
    username: 'user1',
    email: 'user1@gmail.com',
    password: '12345',
    firstName: 'User',
    lastName: 'One',
    birthDate: DateTime(1990, 1, 1),
    phone: '123456789',
    trainingSessions: [],
    trainingPlans: [],
  ),
  User(
    id: '2',
    username: 'user2',
    email: 'user2@gmail.com',
    password: '123456',
    firstName: 'User',
    lastName: 'Two',
    birthDate: DateTime(1995, 1, 1),
    phone: '987654321',
    trainingSessions: [],
    trainingPlans: [],
  ),
];
