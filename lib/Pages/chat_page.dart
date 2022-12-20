import 'dart:async';
import 'dart:convert';

import 'package:chat_app/CustomUI/custom_card.dart';
import 'package:chat_app/Models/conversation_model.dart';
import 'package:chat_app/Models/users_model.dart';
import 'package:chat_app/Screens/select_contact.dart';
import 'package:chat_app/Util/app_rebuilder.dart';
import 'package:chat_app/Util/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, this.userList, this.currentUser}) : super(key: key);
  final List<User>? userList;
  final User? currentUser;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_ChatPageState>()?.restartApp();
  }

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late List<Conversation> _conversations;
  late Future<List<Conversation>> futureRecentChat;
  late Function listener;
  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  void initState() {
    super.initState();
    futureRecentChat = fetchRecentChat();
  }

  Future<List<Conversation>> fetchRecentChat() async {
    final response = await http.get(
      Uri.parse("$API/room"),
      headers: {
        "Authorization": 'Bearer ${widget.currentUser!.token}',
      },
    );
    if (response.statusCode == 200) {
      return Conversations.fromJson(jsonDecode(response.body)).conversations;
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  @override
  Widget build(BuildContext context) {
    listener() {
      ChatPage.restartApp(context);
    }

    return Scaffold(
      key: key,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => SelectContact(userList: widget.userList, currentUser: widget.currentUser)))
              .then((value) {
            ChatPage.restartApp(context);
            AppBuilder.of(context)?.rebuild();
            fetchRecentChat();
          });
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
                  //????
                  recentUserChat: _conversations[index].postedByUserId,
                  listener: listener,
                  bContext: context,
                  currentChat: widget.currentUser,
                  conversation: _conversations[index],
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
