String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email is required';
  }
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  if (!emailRegex.hasMatch(email)) {
    return 'Invalid email format';
  }
  return null;
}

String? validateUsername(String? username) {
  if (username == null || username.isEmpty) {
    return 'Username is required';
  }
  final usernameRegex = RegExp(r'^[a-zA-Z0-9_-]{3,30}$');
  if (!usernameRegex.hasMatch(username)) {
    return 'Invalid username format';
  }
  return null;
}

String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return 'Password is required';
  }
  final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{12,128}$');
  if (!passwordRegex.hasMatch(password)) {
    return 'Password must be 12-128 characters long and include at least one uppercase letter, one lowercase letter, one number, and one special character';
  }
  return null;
}
