import 'package:chat_app/CustomUI/button_card.dart';
import 'package:chat_app/Models/chat_model.dart';
import 'package:chat_app/Models/user_model.dart';
import 'package:chat_app/Screens/home_screen.dart';
import 'package:chat_app/Screens/login_screen.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Users _users;
  late List<User>? userList;
  late User currentUser;
  @override
  void initState() {
    super.initState();
    fetchUsers().then((data) {
      setState(() {
        _users = data;
        userList = _users.users;
      });
    });
  }

  Future<Users> fetchUsers() async {
    final response = await http.get(Uri.parse("http://192.168.1.5:8080/users"));
    if (response.statusCode == 200) {
      return Users.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      bool hasUser = false;
      String? _userId = "";
      int i = 0;
      userList?.forEach((usr) {
        if (usr.firstName == (data.name) && usr.lastName == data.password) {
          hasUser = true;
          _userId = usr.id;
          currentUser = usr;
        }
        i++;
      });
      if (hasUser) {
        userList!.remove(currentUser);
        userLogin(_userId).then((token) {
          currentUser.token = token;
        });
        return "";
      } else
        return "User not found, please try again!";
    });
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      //some logic
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
          builder: (context) => HomeScreen(
            chats: userList,
            currentChat: currentUser,
          ),
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
      theme: LoginTheme(primaryColor: Colors.deepPurple, accentColor: Colors.yellow, errorColor: Colors.deepOrange),
    );
  }

  Future<String> userLogin(String? userId) async {
    final response = await http.post(Uri.parse("http://192.168.1.5:8080/login/${userId}"), body: "");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return data['authorization'];
    } else {
      throw Exception('Failed to load User');
    }
  }
}
