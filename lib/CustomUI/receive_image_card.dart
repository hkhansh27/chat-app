import 'package:flutter/material.dart';

class ReceiveImageCard extends StatelessWidget {
  const ReceiveImageCard({Key? key, required this.path}) : super(key: key);
  final String path;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          height: MediaQuery.of(context).size.height / 2.3,
          width: MediaQuery.of(context).size.width / 2.3,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey[500]),
          child: Card(
            margin: const EdgeInsets.all(2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Image.network(
              "http://192.168.1.5:3000/uploads/$path",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
