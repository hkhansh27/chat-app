import 'package:chat_app/Models/conversation_model.dart';
import 'package:chat_app/Models/users_model.dart';
import 'package:chat_app/Pages/chat_page.dart';
import 'package:chat_app/Screens/individual_page.dart';
import 'package:chat_app/Util/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key,
      required this.recentUserChat,
      required this.currentChat,
      required this.conversation,
      required this.listener,
      required this.bContext})
      : super(key: key);
  final Conversation conversation;
  final User? recentUserChat;
  final User? currentChat;
  final Function listener;
  final BuildContext bContext;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualPage(
                      recentUserChat: recentUserChat,
                      currentChat: currentChat,
                      conversation: conversation,
                    ))).then((value) {
          ChatPage.restartApp(context);
          listener();
          fetchRecentChat();
        });
      },
      child: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
              radius: 25,
              child: Icon(
                Icons.person,
                // (chatModel.isGroup!) ? Icons.groups : Icons.person,
                color: Colors.white,
              ),
              backgroundColor: Colors.blueGrey,
            ),
            title:
                Text("${conversation.chatRoomId}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Row(
              children: [
                const Icon(Icons.done),
                const SizedBox(
                  width: 3,
                ),
                Container(
                    width: MediaQuery.of(context).size.width - 200, child: Text(conversation.message!.messageText))
                // Text("${chatModel.currentMessage}")
              ],
            ),
            trailing: Text(DateTime.now().toString().substring(10, 16)),
            // Text("${chatModel.time}"),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchRecentChat() async {
    await http.get(
      Uri.parse("$API/room"),
      headers: {
        "Authorization": 'Bearer ${currentChat!.token}',
      },
    );
  }
}
