import 'package:flutter/material.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          callCard("Khanh 1", Icons.call_made, Colors.green, "Sep 2, 20:31"),
          callCard("Khanh 2", Icons.call_missed, Colors.red, "Sep 2, 20:37"),
          callCard("Khanh 3", Icons.call_made, Colors.green, "Oct 3, 11:31"),
          callCard("Khanh 4", Icons.call_made, Colors.green, "July 2, 9:31")
        ],
      ),
    );
  }

  Widget callCard(String name, IconData iconData, Color iconColor, String time) {
    return Card(
      margin: const EdgeInsets.only(bottom: 0.3),
      child: ListTile(
          leading: const CircleAvatar(
            radius: 25,
          ),
          title: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
          subtitle: Row(children: [
            Icon(
              iconData,
              color: iconColor,
              size: 20,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(time, style: const TextStyle(fontSize: 13))
          ]),
          trailing: const Icon(
            Icons.call,
            size: 26,
            color: Colors.teal,
          )),
    );
  }
}
