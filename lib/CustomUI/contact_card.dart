import 'package:chat_app/Models/chat_model.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, required this.contact}) : super(key: key);
  final ChatModel contact;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        child: Stack(children: [
          const CircleAvatar(
            radius: 20,
            child: Icon(Icons.person, color: Colors.white),
            backgroundColor: Colors.blueGrey,
          ),
          contact.select!
              ? const Positioned(
                  bottom: 5,
                  right: 5,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container()
        ]),
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
    );
  }
}
