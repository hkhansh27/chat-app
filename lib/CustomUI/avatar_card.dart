import 'package:chat_app/Models/chat_model.dart';
import 'package:flutter/material.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({Key? key, required this.contact}) : super(key: key);

  final ChatModel contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(children: const [
            CircleAvatar(
              radius: 25,
              child: Icon(Icons.person, color: Colors.white),
              backgroundColor: Colors.blueGrey,
            ),
            Positioned(
              bottom: 2,
              right: 1,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              ),
            )
          ]),
          Text("${contact.name}")
        ],
      ),
    );
  }
}
