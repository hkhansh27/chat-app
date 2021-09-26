import 'package:chat_app/Models/chat_model.dart';
import 'package:flutter/material.dart';

class IndividualPage extends StatefulWidget {
  const IndividualPage({Key? key, required this.chatModel}) : super(key: key);
  final ChatModel chatModel;
  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 70,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_back, size: 25),
                // const Padding(padding: EdgeInsets.only(right: 20)),
                CircleAvatar(
                  child: Icon(widget.chatModel.isGroup! ? Icons.groups : Icons.person),
                  radius: 20,
                  backgroundColor: Colors.deepPurpleAccent,
                )
              ],
            ),
          ),
          title: InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.chatModel.name!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                const Text("Last seen 2h ago",
                    style: TextStyle(
                      fontSize: 13,
                    ))
              ],
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
            PopupMenuButton(onSelected: (value) {
              print(value);
            }, itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem(
                  child: Text("View contact"),
                  value: "View contact",
                ),
                PopupMenuItem(
                  child: Text("Media, links and files"),
                  value: "Media, links and files",
                ),
                PopupMenuItem(
                  child: Text("Web"),
                  value: "Web",
                ),
                PopupMenuItem(
                  child: Text("Search"),
                  value: "Search",
                ),
                PopupMenuItem(
                  child: Text("Mute notifications"),
                  value: "Mute notifications",
                ),
                PopupMenuItem(
                  child: Text("Wallpaper"),
                  value: "Wallpaper",
                ),
              ];
            })
          ]),
    );
  }
}
