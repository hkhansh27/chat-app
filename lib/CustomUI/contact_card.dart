import 'package:chat_app/Models/chat_model.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, required this.contact}) : super(key: key);
  final ChatModel contact;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          child: Icon(Icons.person, color: Colors.white),
          backgroundColor: Colors.blueGrey,
        ),
        title: Text("${contact.name}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Row(
          children: [
            const SizedBox(
              width: 3,
            ),
            Text("${contact.status}")
          ],
        ),
      ),
    );
  }
}
