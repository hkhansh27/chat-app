import 'package:chat_app/CustomUI/avatar_card.dart';
import 'package:chat_app/CustomUI/contact_card.dart';
import 'package:chat_app/Models/users_model.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key, required this.userList}) : super(key: key);
  final List<User>? userList;

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<User> groupSelected = [];

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
                return Container(height: groupSelected.isNotEmpty ? 90 : 10);
              }

              return InkWell(
                  onTap: () {
                    //whether display or hidden an green icon check in contact_card
                    //contacts[index -1] and itemCount + 1 because if amount of users are selected > 0 then in itemBuiler, the index at 0 will be a container
                    if (widget.userList![index - 1].select == false) {
                      setState(() {
                        widget.userList![index - 1].select = true;
                        groupSelected.add(widget.userList![index - 1]);
                      });
                    } else {
                      setState(() {
                        widget.userList![index - 1].select = false;
                        groupSelected.remove(widget.userList![index - 1]);
                      });
                    }
                  },
                  child: ContactCard(user: widget.userList![index - 1]));
            },
            itemCount: widget.userList!.length + 1,
          ),
          //conditional show container which contains users are selected
          groupSelected.isNotEmpty
              ? Column(
                  children: [
                    Container(
                        height: 75,
                        color: Colors.white,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              //whether display or hidden an green icon check in avatar_card
                              if (widget.userList![index].select == true) {
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        widget.userList![index].select = false;
                                        groupSelected.remove(widget.userList![index]);
                                      });
                                    },
                                    child: AvatarCard(user: widget.userList![index]));
                              } else {
                                return Container();
                              }
                            },
                            itemCount: widget.userList!.length)),
                    const Divider(
                      thickness: 2,
                    ),
                  ],
                )
              : Container(),
          groupSelected.isNotEmpty
              ? Container(
                  height: MediaQuery.of(context).size.height + 200,
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                    label: const Text('Approve'),
                    icon: const Icon(Icons.thumb_up),
                    backgroundColor: Colors.pink,
                  ),
                )
              : Container()
        ]));
  }
}
