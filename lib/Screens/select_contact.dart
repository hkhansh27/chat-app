import 'package:chat_app/CustomUI/button_card.dart';
import 'package:chat_app/CustomUI/contact_card.dart';
import 'package:chat_app/Models/chat_model.dart';
import 'package:flutter/material.dart';

import 'create_group.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<ChatModel> contacts = [
    ChatModel(id: 1, name: "Khanh 1", status: "Ahihihi1"),
    ChatModel(id: 2, name: "Khanh 2", status: "Ahihihi2"),
    ChatModel(id: 3, name: "Khanh 3", status: "Ahihihi3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Select Contact", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("26 contacts", style: TextStyle(fontSize: 13))
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
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
            if (index == 0) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) => const CreateGroup()));
                },
                child: const ButtonCard(
                  icon: Icons.group_add_sharp,
                  name: "New group",
                ),
              );
            }
            if (index == 1) {
              return InkWell(onTap: () {}, child: const ButtonCard(icon: Icons.person_add, name: "New contact"));
            }
            return InkWell(onTap: () {}, child: ContactCard(contact: contacts[index - 2]));
          },
          itemCount: contacts.length + 2, // "+2" because two btn card in the top of page
        ));
  }
}
