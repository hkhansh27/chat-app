import 'package:chat_app/CustomUI/button_card.dart';
import 'package:chat_app/CustomUI/contact_card.dart';
import 'package:chat_app/Models/chat_model.dart';
import 'package:flutter/material.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<ChatModel> contacts = [
    ChatModel(name: "Khanh 1", status: "Ahihihi1"),
    ChatModel(name: "Khanh 2", status: "Ahihihi2"),
    ChatModel(name: "Khanh 3", status: "Ahihihi3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Contact", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("26 contacts", style: const TextStyle(fontSize: 13))
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            PopupMenuButton(onSelected: (value) {
              print(value);
            }, itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem(
                  child: Text("Invite a friend"),
                  value: "Invite a friend",
                ),
                PopupMenuItem(
                  child: Text("Contacts"),
                  value: "Contacts",
                ),
                PopupMenuItem(
                  child: Text("Refresh"),
                  value: "Refresh",
                ),
                PopupMenuItem(
                  child: Text("Help"),
                  value: "Help",
                ),
              ];
            })
          ],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            if (index == 0)
              return ButtonCard(
                icon: Icons.group_add_sharp,
                name: "New group",
              );
            if (index == 1) return ButtonCard(icon: Icons.person_add, name: "New contact");
            return ContactCard(contact: contacts[index - 2]);
          },
          itemCount: contacts.length + 2, // "+2" because two btn card in the top of page
        ));
  }
}
