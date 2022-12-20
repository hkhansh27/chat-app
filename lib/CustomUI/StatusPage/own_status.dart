import 'package:flutter/material.dart';

class OwnStatus extends StatefulWidget {
  const OwnStatus({Key? key}) : super(key: key);

  @override
  _OwnStatusState createState() => _OwnStatusState();
}

class _OwnStatusState extends State<OwnStatus> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Stack(
          children: const [
            CircleAvatar(
              radius: 27,
              backgroundColor: Colors.blue,
              // backgroundImage: AssetImage(""),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                backgroundColor: Colors.greenAccent,
                radius: 10,
                child: Icon(Icons.circle, size: 20, color: Colors.green),
              ),
            )
          ],
        ),
        title: const Text("Khanh 1", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        subtitle: const Text("Hello", style: TextStyle(fontSize: 13, color: Colors.grey)));
  }
}
