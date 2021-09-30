import 'package:chat_app/Models/chat_model.dart';
import 'package:chat_app/Screens/individual_page.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.chatModel, required this.currentChat}) : super(key: key);
  final ChatModel chatModel, currentChat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => IndividualPage(chatModel: chatModel, currentChat: currentChat)));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 25,
              child: Icon(
                (chatModel.isGroup!) ? Icons.groups : Icons.person,
                color: Colors.white,
              ),
              backgroundColor: Colors.blueGrey,
            ),
            title: Text("${chatModel.name}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            subtitle: Row(
              children: [
                const Icon(Icons.done),
                const SizedBox(
                  width: 3,
                ),
                Text("${chatModel.currentMessage}")
              ],
            ),
            trailing: Text("${chatModel.time}"),
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
