import 'package:chat_app/Models/users_model.dart';
import 'package:chat_app/Pages/camera_page.dart';
import 'package:chat_app/Pages/chat_page.dart';
import 'package:chat_app/Pages/status_page.dart';
import 'package:flutter/material.dart';

import 'call_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.userList, this.currentUser}) : super(key: key);
  final List<User>? userList;
  final User? currentUser;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TikTik",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          PopupMenuButton(onSelected: (value) {
            print(value);
          }, itemBuilder: (BuildContext context) {
            return const [
              PopupMenuItem(
                child: Text("New group"),
                value: "New group",
              ),
              PopupMenuItem(
                child: Text("New broadcast"),
                value: "New broadcast",
              ),
              PopupMenuItem(
                child: Text("Web"),
                value: "Web",
              ),
              PopupMenuItem(
                child: Text("Starred a message"),
                value: "Starred a message",
              ),
              PopupMenuItem(
                child: Text("Settings"),
                value: "Settings",
              ),
            ];
          })
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.green[400],
          tabs: const [
            Tab(icon: Icon(Icons.camera_alt)),
            Tab(text: "Chats"),
            Tab(text: "Status"),
            Tab(text: "Calls"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          const CameraPage(),
          ChatPage(userList: widget.userList!, currentUser: widget.currentUser),
          const StatusPage(),
          const CallScreen(),
        ],
      ),
    );
  }
}
