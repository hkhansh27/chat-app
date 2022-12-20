import 'package:chat_app/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/Screens/camera_screen.dart';
import 'package:camera/camera.dart';

Future<void> main() async {
  //to use camera plugin must do this
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'SourceSansPro',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(secondary: Colors.pinkAccent)),
      // home: LoginPage(),
      home: const LoginScreen(),
    );
  }
}
