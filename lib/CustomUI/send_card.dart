import 'package:chat_app/Models/msg_model.dart';
import 'package:flutter/material.dart';

class SendCard extends StatelessWidget {
  SendCard({Key? key, required this.message, required this.time}) : super(key: key);
  final String message, time;

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
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Positioned(
                  bottom: 4,
                  right: 10,
                  child: Row(children: [
                    Text(
                      // message.createdAt.toString(),
                      time,
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
