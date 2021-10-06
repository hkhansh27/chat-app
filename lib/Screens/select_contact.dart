import 'dart:convert';

import 'package:chat_app/CustomUI/button_card.dart';
import 'package:chat_app/CustomUI/contact_card.dart';
import 'package:chat_app/Models/room_model.dart';
import 'package:chat_app/Models/users_model.dart';
import 'package:chat_app/Screens/home_screen.dart';
import 'package:chat_app/Util/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'create_group.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key, this.userList, this.currentUser}) : super(key: key);
  final List<User>? userList;
  final User? currentUser;

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) =>
                              CreateGroup(userList: widget.userList, currentUser: widget.currentUser)));
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
            return InkWell(
                onTap: () async {
                  await newChatRoom(widget.currentUser!.token, widget.userList![index - 2].id, context, widget.userList,
                      widget.currentUser);
                },
                child: ContactCard(user: widget.userList![index - 2]));
          },
          itemCount: widget.userList!.length + 2, // "+2" because two btn card in the top of page
        ));
  }
}

Future<void> newChatRoom(String? tokenCurrentUser, String? otherUserId, BuildContext context, List<User>? userList,
    User? currentUser) async {
  try {
    var otherUserIds = [];
    otherUserIds.add(otherUserId);
    final response = await http.post(Uri.parse('$API/room/initiate'),
        // Send authorization headers to the backend.
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": 'Bearer $tokenCurrentUser',
        },
        body: jsonEncode(<String, dynamic>{
          "userIds": otherUserIds,
          "type": "member-to-member",
        }));

    Room room = Room.fromJson(jsonDecode(response.body)['chatRoom']);

    if (room.isNew!) {
      await http.post(Uri.parse('$API/room/${room.chatRoomId}/message'), headers: {
        "Authorization": 'Bearer $tokenCurrentUser',
      }, body: {
        "messageText": "Hello"
      });
    }

    // Future.delayed(Duration(seconds: 4), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => HomeScreen(
    //               userList: userList,
    //               currentUser: currentUser,
    //             )),
    //   );
    // }
    // );
  } catch (e) {
    throw e;
  }
}
