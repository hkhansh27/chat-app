import 'package:chat_app/Models/chat_model.dart';
import 'package:chat_app/Models/rooms_model.dart';
import 'package:chat_app/Models/users_model.dart';
import 'package:chat_app/Screens/individual_page.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.chatModel, required this.currentChat, required this.conversation})
      : super(key: key);
  final Conversation conversation;
  final User chatModel, currentChat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualPage(
                      chatModel: chatModel,
                      currentChat: currentChat,
                      conversation: conversation,
                    )));
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
            title: Text("${chatModel.firstName}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Row(
              children: [
                const Icon(Icons.done),
                const SizedBox(
                  width: 3,
                ),
                Text(conversation.message!.messageText)
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
}
