import 'dart:async';
import 'dart:convert';

import 'package:chat_app/CustomUI/custom_card.dart';
import 'package:chat_app/Models/rooms_model.dart';
import 'package:chat_app/Models/users_model.dart';
import 'package:chat_app/Screens/select_contact.dart';
import 'package:chat_app/Util/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.chats, required this.currentChat}) : super(key: key);
  final List<User> chats;
  final User currentChat;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late List<Conversation> _conversations;
  late Future<List<Conversation>> futureRecentChat;
  @override
  void initState() {
    super.initState();
    futureRecentChat = fetchRecentChat();
  }

  Future<List<Conversation>> fetchRecentChat() async {
    final response = await http.get(
      Uri.parse("$API/room"),
      headers: {
        "Authorization": 'Bearer ${widget.currentChat.token}',
      },
    );
    if (response.statusCode == 200) {
      return Rooms.fromJson(jsonDecode(response.body)).conversations;
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (builder) => const SelectContact()));
        },
        child: const Icon(Icons.chat),
      ),
      body: FutureBuilder(
        future: futureRecentChat,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //fetch data from db to local variable by fetchRecent function
            _conversations = snapshot.data as List<Conversation>;
            return ListView.builder(
              itemCount: _conversations.length,
              itemBuilder: (context, index) {
                return CustomCard(
                  chatModel: widget.chats[index],
                  currentChat: widget.currentChat,
                  conversation: _conversations[index],
                );
              },
            );
          } else
            return const CircularProgressIndicator();
        },
      ),
    );
  }
}
