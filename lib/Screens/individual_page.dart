import 'dart:convert';

import 'package:chat_app/CustomUI/receive_card.dart';
import 'package:chat_app/CustomUI/send_card.dart';

import 'package:chat_app/Models/msg_model.dart';
import 'package:chat_app/Models/conversation_model.dart';
import 'package:chat_app/Models/users_model.dart';
import 'package:chat_app/Pages/chat_page.dart';
import 'package:chat_app/Screens/camera_screen.dart';
import 'package:chat_app/Util/app_rebuilder.dart';
import 'package:chat_app/Util/const.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class IndividualPage extends StatefulWidget {
  const IndividualPage({Key? key, required this.conversation, required this.currentChat, required this.recentUserChat})
      : super(key: key);

  final Conversation conversation;
  final User? recentUserChat;
  final User? currentChat;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool showIcon = false;
  bool sendBtn = false;

  late Future<List<Conversation>> futureConversation;
  late List<Conversation> conversations;
  // late List<Conversation> _conversations;

  late ScrollController _scrollController;
  //handle keyboard and emojipicker open at the same time (0)
  FocusNode focusNode = FocusNode();

  io.Socket? socket;
  final TextEditingController _textEditingController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? file;

  var _otherUserId = <String?>{};
  late List<User>? _usersInRoom = [];

  @override
  void initState() {
    super.initState();
    futureConversation = fetchConversationInRoom();
    //auto scroll to newest message is send (2)
    _scrollController = ScrollController();
    //handle when we click on back btn, the only emoji or keyboard is hidden not back to the homescreen (1)
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showIcon = false;
        });
      }
    });
    connect();
  }

  // @override
  // void setState(fn) {
  //   if (mounted) {
  //     super.setState(fn);
  //   }
  // }
  @override
  void dispose() {
    super.dispose();
    socket!.emit('disconnect', '');
    socket!.close();
  }

  void connect() {
    socket = io.io(API, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    socket!.connect();
    socket!.emit("identity", widget.currentChat!.id);
    socket.onConnect((_) {
      print('connected');

      socket!.on("newMessage", (_data) {
        setMessage(_data['postedByUser']['_id'], _data['message']['message'], _data['message']['type']);
        //FIX: auto scroll to newest message does not working when we leave and join room chat again
        // autoScrollToNewest();
      });
    });
  }

  void setMessage(String postedByUserId, String message, String type) {
    User _usr = User(id: postedByUserId);
    Message _msg = Message(message: message, type: type);

    Conversation cvs = Conversation(
      postedByUserId: _usr,
      message: _msg,
    );

    if (mounted) {
      setState(() {
        conversations.add(cvs);
      });
    }
  }

  Future<void> sendMsg(String msg) async {
    await http.post(Uri.parse('$API/room/${conversations[0].chatRoomId}/message'),
        // Send authorization headers to the backend.
        headers: {
          "Authorization": 'Bearer ${widget.currentChat!.token}',
        }, body: {
      "message": msg,
      "type": '0',
    });
  }

  void sendImage(String path, String message) async {
    print("💰💰💰💰💰 Caption cua anh la  $message");

//get extension of file from path
    String extension = path.split('.').last;

    //send file to api
    var request = http.MultipartRequest("POST", Uri.parse("$API/room/${conversations[0].chatRoomId}/message"));

    if (path.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath("message", path));
      if (extension == "mp4") {
        request.fields['type'] = '2';
      } else {
        request.fields['type'] = '1';
      }
    }

    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": 'Bearer ${widget.currentChat!.token}',
    });

    http.StreamedResponse response = await request.send();

    var httpRespone = await http.Response.fromStream(response);
    var data = json.decode(httpRespone.body);
    setMessage("send", message, path);

    // var request = http.MultipartRequest("POST", Uri.parse("http://192.168.1.14:3000/addImage"));
    // if (path.isNotEmpty) {
    //   request.files.add(await http.MultipartFile.fromPath("img", path));
    // }
    // request.headers.addAll({
    //   "Content-type": "multipart/form-data",
    // });
    // http.StreamedResponse response = await request.send();

    // var httpRespone = await http.Response.fromStream(response);
    // var data = json.decode(httpRespone.body);

    // setMessage("send", message, path);
    // socket.emit("message", {
    //   "message": message,
    //   "idSender": widget.currentChat.id,
    //   "idReceiver": widget.chatModel.id,
    //   "path": data['path']
    // });
  }

  Future<List<Conversation>> fetchConversationInRoom() async {
    final response = await http.get(
      Uri.parse("$API/room/${widget.conversation.chatRoomId}"),
      headers: {
        "Authorization": 'Bearer ${widget.currentChat!.token}',
      },
    );

    if (response.statusCode == 200) {
      //remove current logged user in user fetch from db to render name's chat room
      var _usrs = Users.fromJson(jsonDecode(response.body));
      setState(() {
        _usrs.users?.removeWhere((item) => item.id == widget.currentChat!.id);
        _usersInRoom = _usrs.users;
      });

      List<Conversation> _cvsList = Conversations.fromJson(jsonDecode(response.body)).conversations;
      //push all ids in this conversation to a set<>
      await Future.forEach(_cvsList, (cvs) {
        Conversation _cvs = cvs as Conversation;
        setState(() {
          _otherUserId.add(_cvs.postedByUserId!.id);
        });
      });

      //socket subcribe current user login and others to rooom
      _otherUserId.forEach((_id) {
        socket!.emit('subscribe', {widget.conversation.chatRoomId, _id});
      });

      return _cvsList;
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBuilder(builder: (context) {
      return Stack(children: [
        Scaffold(
          backgroundColor: Colors.white70,
          appBar: AppBar(
              leadingWidth: 70,
              leading: InkWell(
                onTap: () {
                  AppBuilder.of(context)?.rebuild();
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.arrow_back, size: 25),
                    CircleAvatar(
                      child: Icon(Icons.person, color: Colors.white),
                      // Icon(widget.chatModel.isGroup! ? Icons.groups : Icons.person, color: Colors.white),
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
                    Text(_usersInRoom?.join(',') as String,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    const Text("Online",
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
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder(
                      future: futureConversation,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          conversations = snapshot.data as List<Conversation>;
                          return ListView.builder(
                              controller: _scrollController,
                              itemCount: conversations.length + 1,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (index == conversations.length) {
                                  return Container(
                                    height: 70,
                                  );
                                }
                                if (conversations[index].postedByUserId!.id == widget.currentChat!.id) {
                                  return SendCard(
                                      message: conversations[index].message!.message!,
                                      type: conversations[index].message!.type!,
                                      //FIX: render sent message's time incorrect
                                      time: conversations[index].createdAt == null
                                          ? DateTime.now().toString().substring(10, 16)
                                          : conversations[index].createdAt!.substring(11, 16));
                                  //  if (messages[index].path.isNotEmpty) {
                                  //   return SendImageCard(path: messages[index].path);
                                  // } else {
                                  //   return SendCard(data: _cvs[index].message!.messageText);
                                  // }
                                } else {
                                  // if (messages[index].path.isNotEmpty) {
                                  //   return ReceiveImageCard(path: messages[index].path);
                                  // } else {
                                  return RecevieCard(
                                      message: conversations[index].message!.message!,
                                      type: conversations[index].message!.type!,
                                      //FIX: render sent message's time incorrect
                                      time: conversations[index].createdAt == null
                                          ? DateTime.now().toString().substring(10, 16)
                                          : conversations[index].createdAt!.substring(11, 16));
                                }
                              }
                              // }
                              );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
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
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        setState(() {
                                          sendBtn = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendBtn = false;
                                        });
                                      }
                                    },
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
                                          IconButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) => CameraScreen(
                                                      onSendImage: sendImage,
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(Icons.camera_alt))
                                        ])),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                child: CircleAvatar(
                                  child: IconButton(
                                      onPressed: () {
                                        if (sendBtn) {
                                          //auto scroll to newest message is sent (2)
                                          // autoScrollToNewest();
                                          sendMsg(_textEditingController.text);
                                        }
                                        //clear text form field after sending a message
                                        _textEditingController.clear();
                                        //btn send will be an mic icon after sending a message
                                        setState(() {
                                          sendBtn = false;
                                        });
                                      },
                                      icon: Icon(
                                        sendBtn ? Icons.send : Icons.mic,
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
                                  child: EmojiPicker(onEmojiSelected: (Category? category, Emoji emoji) {
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
    });
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
                iconCreation(Icons.insert_drive_file, Colors.indigo, "Video", () async {
                  file = await _imagePicker.pickVideo(source: ImageSource.gallery);
                  sendImage(file!.path, "");
                  Navigator.of(context).pop();
                }),
                const SizedBox(width: 40),
                iconCreation(Icons.camera_alt, Colors.pinkAccent, "Camera", () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CameraScreen(onSendImage: sendImage),
                    ),
                  );
                }),
                const SizedBox(width: 40),
                iconCreation(Icons.insert_photo, Colors.green, "Photo", () async {
                  file = await _imagePicker.pickImage(source: ImageSource.gallery);
                  sendImage(file!.path, "");
                  Navigator.of(context).pop();
                }),
              ]),
              const SizedBox(height: 25),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                iconCreation(Icons.headphones, Colors.yellow, "Audio", () {}),
                const SizedBox(width: 40),
                iconCreation(Icons.location_pin, Colors.blue, "Location", () {}),
                const SizedBox(width: 40),
                iconCreation(Icons.person, Colors.black, "Contact", () {}),
              ])
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text, Function onTap) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(children: [
        CircleAvatar(radius: 30, backgroundColor: color, child: Icon(icon, size: 28, color: Colors.white)),
        const SizedBox(height: 5),
        Text(text)
      ]),
    );
  }

  void autoScrollToNewest() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }
}
