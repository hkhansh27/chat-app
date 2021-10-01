import 'package:flutter/material.dart';

class OthersStatus extends StatelessWidget {
  OthersStatus({Key? key, this.name, this.time, this.colorIcon}) : super(key: key);
  final String? name, time;
  final Color? colorIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: colorIcon
          // backgroundImage: AssetImage(""),
          ),
      title: Text(name!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      subtitle: Text(time!, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
    );
  }
}
