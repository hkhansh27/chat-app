import 'package:chat_app/CustomUI/avatar_card.dart';
import 'package:chat_app/CustomUI/contact_card.dart';
import 'package:chat_app/Models/chat_model.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(name: "Khanh 1", status: "Ahihihi1"),
    ChatModel(name: "Khanh 2", status: "Ahihihi2"),
    ChatModel(name: "Khanh 3", status: "Ahihihi3"),
  ];

  List<ChatModel> groupSelected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("New Group", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("Add participants", style: TextStyle(fontSize: 13))
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
        ),
        body: Stack(children: [
          ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(height: groupSelected.length > 0 ? 90 : 10);
              }

              return InkWell(
                  onTap: () {
                    //whether display or hidden an green icon check in contact_card
                    //contacts[index -1] and itemCount + 1 because if amount of users are selected > 0 then in itemBuiler, the index at 0 will be a container
                    if (contacts[index - 1].select == false) {
                      setState(() {
                        contacts[index - 1].select = true;
                        groupSelected.add(contacts[index - 1]);
                      });
                    } else {
                      setState(() {
                        contacts[index - 1].select = false;
                        groupSelected.remove(contacts[index - 1]);
                      });
                    }
                  },
                  child: ContactCard(contact: contacts[index - 1]));
            },
            itemCount: contacts.length + 1,
          ),
          //conditional show container which contains users are selected
          groupSelected.length > 0
              ? Column(
                  children: [
                    Container(
                        height: 75,
                        color: Colors.white,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              //whether display or hidden an green icon check in avatar_card
                              if (contacts[index].select == true) {
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        contacts[index].select = false;
                                        groupSelected.remove(contacts[index]);
                                      });
                                    },
                                    child: AvatarCard(contact: contacts[index]));
                              } else {
                                return Container();
                              }
                            },
                            itemCount: contacts.length)),
                    const Divider(
                      thickness: 2,
                    )
                  ],
                )
              : Container(),
        ]));
  }
}
