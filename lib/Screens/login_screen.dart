import 'package:chat_app/CustomUI/button_card.dart';
import 'package:chat_app/Models/chat_model.dart';
import 'package:chat_app/Screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel currentChat;
  List<ChatModel> chats = [
    ChatModel(id: 1, name: "Khanh 1", isGroup: false, currentMessage: "Ohohoho", time: "16:26"),
    ChatModel(id: 2, name: "Khanh 2", isGroup: false, currentMessage: "Ahihiihihi", time: "21:26"),
    ChatModel(id: 3, name: "Khanh 3", isGroup: false, currentMessage: "Akakaka", time: "19:26"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) => InkWell(
              onTap: () {
                currentChat = chats.removeAt(index);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => HomeScreen(
                              chats: chats,
                              currentChat: currentChat,
                            )));
              },
              child: ButtonCard(name: chats[index].name, icon: chats[index].isGroup! ? Icons.groups : Icons.person))),
    );
  }
}
