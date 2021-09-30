import 'package:chat_app/CustomUI/custom_card.dart';
import 'package:chat_app/Models/chat_model.dart';
import 'package:chat_app/Screens/select_contact.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.chats, required this.currentChat}) : super(key: key);
  final List<ChatModel> chats;
  final ChatModel currentChat;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (builder) => const SelectContact()));
          },
          child: const Icon(Icons.chat),
        ),
        body: ListView.builder(
          itemBuilder: (contex, index) {
            return CustomCard(chatModel: widget.chats[index], currentChat: widget.currentChat);
          },
          itemCount: widget.chats.length,
        ));
  }
}
