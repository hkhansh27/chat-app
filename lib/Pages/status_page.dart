import 'package:chat_app/CustomUI/StatusPage/others_status.dart';
import 'package:chat_app/CustomUI/StatusPage/own_status.dart';
import 'package:chat_app/Screens/camera_screen.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(height: 48, child: Container()),
          const SizedBox(
            height: 13,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CameraScreen(
                    onSendImage: () {},
                  ),
                ),
              );
            },
            backgroundColor: Colors.greenAccent[700],
            elevation: 5,
            child: const Icon(Icons.camera_alt),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            const OwnStatus(),
            Container(
              height: 33,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[300],
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                child: Text("Recent", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            ),
            OthersStatus(
              name: "Khanh 3",
              time: "Online",
              colorIcon: Colors.amber,
            ),
            OthersStatus(
              name: "Khanh 5",
              time: "To day at 7:25",
              colorIcon: Colors.green,
            ),
            OthersStatus(name: "Khanh 4", time: "20 hours ago", colorIcon: Colors.red),
          ],
        ),
      ),
    );
  }
}
