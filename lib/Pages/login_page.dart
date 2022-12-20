import 'package:chat_app/Screens/login_screen.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter/material.dart';

const users = {
  'hihihihi': 'khanh',
};

class LoginPage extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return "";
    });
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return "";
    });
  }

  FormFieldValidator<String> _validatorFirstName = (value) {
    if (value!.isEmpty) {
      return 'Invalid first name!';
    }
    return null;
  };

  FormFieldValidator<String> _validatorLastName = (value) {
    if (value!.isEmpty) {
      return 'Invalid last name!';
    }
    return null;
  };

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'TIKTIK',
      userValidator: _validatorFirstName,
      passwordValidator: _validatorLastName,
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
      },
      onRecoverPassword: _recoverPassword,
      messages: LoginMessages(
        userHint: 'First name',
        passwordHint: 'Last name',
        confirmPasswordHint: 'Confirm',
        loginButton: 'LOG IN',
        signupButton: 'REGISTER',
        forgotPasswordButton: 'Forgot huh?',
      ),
    );
  }
}
