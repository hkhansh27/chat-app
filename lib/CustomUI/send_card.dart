import 'package:chat_app/Models/msg_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:open_file/open_file.dart';

import '../Util/const.dart';

class SendCard extends StatefulWidget {
  SendCard({Key? key, required this.message, required this.time, required this.type}) : super(key: key);
  final String message, time, type;

  @override
  State<SendCard> createState() => _SendCardState();
}

class _SendCardState extends State<SendCard> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    widget.type == '2' ? _controller = VideoPlayerController.network('$API/${widget.message}') : null;
    widget.type == '2' ? _controller?.initialize().then((_) => setState(() {})) : null;
    widget.type == '2'
        ? _controller?.addListener(() {
            setState(() {});
          })
        : null;
    widget.type == '2' ? _controller?.setLooping(true) : null;
    widget.type == '2' ? _controller?.play() : null;
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  void activate() {
    super.activate();
    _controller?.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 35,
        ),
        child: Card(
            elevation: 1,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            color: Colors.purple[100],
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 30, top: 10, bottom: 20),
                child: widget.type == '0'
                    ? Text(
                        widget.message,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      )
                    : widget.type == '1'
                        ? Image.network('$API/${widget.message}')
                        : widget.type == '2'
                            ? _controller!.value.isInitialized
                                ? AspectRatio(
                                    aspectRatio: _controller?.value.aspectRatio ?? 1,
                                    child: VideoPlayer(_controller!),
                                  )
                                : Container(child: const CircularProgressIndicator())
                            : Container(
                                child: GestureDetector(
                                  onTap: () async {
                                    await OpenFile.open('$API/${widget.message}');
                                  },
                                  child: const Icon(Icons.file_present),
                                ),
                              ),
              ),
              Positioned(
                  bottom: 4,
                  right: 10,
                  child: Row(children: [
                    Text(
                      // message.createdAt.toString(),
                      widget.time,
                      style: const TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.done,
                      size: 13,
                    )
                  ]))
            ])),
      ),
    );
  }
}
