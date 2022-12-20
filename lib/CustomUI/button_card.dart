import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({Key? key, this.name, this.icon}) : super(key: key);

  final String? name;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        child: Icon(icon, color: Colors.white),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      title: Text("$name", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }
}
