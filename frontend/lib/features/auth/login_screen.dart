import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  /*
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String?> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if(!mockUsers.containsKey(data.email)) {
        return 'User doesn't exists';
      }
      if(mockUsers[data.email] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(Signup data) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String email) {
    return Future.delayed(loginTime).then((_) {
      if(!mockUsers.contains(email)) {
        return 'User doesn't exists';
      }
      return null;
    });
  }

  Future<String?> _signupConfirm(String error, LoginData data) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }
  */
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Training Tracker',
      //logo:
      //logoTag:
      //titleTag:
      //navigateBackAfterRecovery:
      //onConfirmRecover:
      //onConfrimSignup:
      //loginAfterSignup: false,
      loginProviders: [
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: () async {
            return null;
          },
        ),
        LoginProvider(
            icon: FontAwesomeIcons.facebook,
            label: 'Facebook',
            callback: () async {
              return null;
            }),
      ],
      //termsOfService: [],
      additionalSignupFields: [
        const UserFormField(
          keyName: 'Username',
          icon: Icon(FontAwesomeIcons.userLarge),
        ),
      ],
      userValidator: (value) {
        if (!value!.contains('@')) {
          return "Email must contain '@'";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value!.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
      onLogin: (loginData) {},
      onSignup: (signupData) {},
      onRecoverPassword: (name) {},
      headerWidget: const IntroWidget(),
    );
  }
}

class IntroWidget extends StatelessWidget {
  const IntroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text("Login"),
            ),
            Expanded(child: Divider()),
          ],
        ),
      ],
    );
  }
}
