import 'package:chat_app/Screens/camera_screen.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CameraScreen(
      onSendImage: () {},
    );
  }
}
