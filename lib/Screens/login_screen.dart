import 'dart:async';
import 'dart:convert';
import 'package:chat_app/Models/users_model.dart';
import 'package:chat_app/Screens/home_screen.dart';
import 'package:chat_app/Util/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
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
        //fetch all uesrs from db include success code and list user in users_model :v
        _users = data;
        //get list users from User
        userList = _users.users;
      });
    });
  }

  Future<Users> fetchUsers() async {
    final response = await http.get(Uri.parse("$API/users"));
    if (response.statusCode == 200) {
      return Users.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      bool hasUser = false;
      String? _userId = "";
      userList?.forEach((usr) {
        if (usr.firstName == (data.name) && usr.lastName == data.password) {
          hasUser = true;
          _userId = usr.id;
          currentUser = usr;
        }
      });
      if (hasUser) {
        //remove logged user from user list
        userList!.remove(currentUser);
        userLogin(_userId).then((token) {
          currentUser.token = token;
        });
        return "";
      } else {
        return "User not found, please try again!";
      }
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
            userList: userList,
            currentUser: currentUser,
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
    final response = await http.post(Uri.parse("$API/login/$userId"), body: "");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return data['authorization'];
    } else {
      throw Exception('Failed to load User');
    }
  }
}
