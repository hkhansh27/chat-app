import 'package:chat_app/CustomUI/send_card.dart';
import 'package:chat_app/CustomUI/receive_card.dart';
import 'package:chat_app/Models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualPage extends StatefulWidget {
  const IndividualPage({Key? key, required this.chatModel}) : super(key: key);
  final ChatModel chatModel;
  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool showIcon = false;
  //handle keyboard and emojipicker open at the same time (0)
  FocusNode focusNode = FocusNode();

  late IO.Socket socket;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    connect();
    //handle when we click on back btn, the only emoji or keyboard is hidden not back to the homescreen (1)
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showIcon = false;
        });
      }
    });
  }

  void connect() {
    socket = IO.io("http://192.168.1.13:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.onConnect((data) => print("Connected"));
    socket.emit("/test", "Hi cu");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
            leadingWidth: 70,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_back, size: 25),
                  CircleAvatar(
                    child: Icon(widget.chatModel.isGroup! ? Icons.groups : Icons.person, color: Colors.white),
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
              }),
            ]),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: WillPopScope(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 130,
                  child: ListView(
                    shrinkWrap: true,
                    children: const [
                      SendCard(),
                      RecevieCard(),
                      SendCard(),
                      RecevieCard(),
                      SendCard(),
                      RecevieCard(),
                      SendCard(),
                      RecevieCard(),
                      SendCard(),
                      RecevieCard(),
                      SendCard(),
                      RecevieCard(),
                      SendCard(),
                      RecevieCard(),
                      SendCard(),
                      RecevieCard(),
                      SendCard(),
                      RecevieCard(),
                      SendCard(),
                      RecevieCard(),
                      SendCard(),
                      RecevieCard(),
                      SendCard(),
                      RecevieCard(),
                      SendCard(),
                      RecevieCard(),
                      SendCard(),
                      RecevieCard(),
                      SendCard(),
                      RecevieCard(),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 55,
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                child: TextFormField(
                                  controller: _textEditingController,
                                  focusNode: focusNode,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type a message",
                                      prefixIcon: IconButton(
                                        icon: const Icon(Icons.emoji_emotions),
                                        onPressed: () {
                                          //handle (0)
                                          focusNode.unfocus();
                                          focusNode.canRequestFocus = false;
                                          setState(() {
                                            showIcon = !showIcon;
                                          });
                                        },
                                      ),
                                      suffixIcon: Row(mainAxisSize: MainAxisSize.min, children: [
                                        IconButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  backgroundColor: Colors.transparent,
                                                  context: context,
                                                  builder: (builder) => bottomShet());
                                            },
                                            icon: const Icon(Icons.attach_file)),
                                        IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt))
                                      ])),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: CircleAvatar(
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.mic,
                                      color: Colors.white,
                                    )),
                                backgroundColor: Colors.deepPurple,
                              ),
                            )
                          ],
                        ),
                        showIcon
                            ? SizedBox(
                                height: 207,
                                child: EmojiPicker(onEmojiSelected: (Category category, Emoji emoji) {
                                  setState(() {
                                    _textEditingController.text += emoji.emoji;
                                  });
                                }))
                            : Container()
                      ],
                    )),
              ],
            ),
            onWillPop: () {
              //handle (1)
              if (showIcon) {
                setState(() {
                  showIcon = false;
                });
              } else {
                Navigator.pop(context);
              }
              return Future.value(false);
            },
          ),
        ),
      )
    ]);
  }

  Widget bottomShet() {
    return Container(
      height: 270,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                iconCreation(Icons.insert_drive_file, Colors.indigo, "Document"),
                const SizedBox(width: 40),
                iconCreation(Icons.camera_alt, Colors.pinkAccent, "Camera"),
                const SizedBox(width: 40),
                iconCreation(Icons.insert_photo, Colors.green, "Photo"),
              ]),
              const SizedBox(height: 25),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                iconCreation(Icons.headphones, Colors.yellow, "Audio"),
                const SizedBox(width: 40),
                iconCreation(Icons.location_pin, Colors.blue, "Location"),
                const SizedBox(width: 40),
                iconCreation(Icons.person, Colors.black, "Contact"),
              ])
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(children: [
        CircleAvatar(radius: 30, backgroundColor: color, child: Icon(icon, size: 28, color: Colors.white)),
        const SizedBox(height: 5),
        Text(text)
      ]),
    );
  }
}
