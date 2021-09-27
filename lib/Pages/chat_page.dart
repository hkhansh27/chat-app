import 'package:chat_app/CustomUI/custom_card.dart';
import 'package:chat_app/Models/chat_model.dart';
import 'package:chat_app/Screens/select_contact.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(name: "Khanh 1", isGroup: false, currentMessage: "Ohohoho", time: "16:26"),
    ChatModel(name: "Khanh 2", isGroup: true, currentMessage: "Ahihiihihi", time: "21:26"),
    ChatModel(name: "Khanh 3", isGroup: false, currentMessage: "Akakaka", time: "19:26"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (builder) => SelectContact()));
          },
          child: const Icon(Icons.chat),
        ),
        body: ListView.builder(
          itemBuilder: (contex, index) {
            return CustomCard(chatModel: chats[index]);
          },
          itemCount: chats.length,
        ));
  }
}
