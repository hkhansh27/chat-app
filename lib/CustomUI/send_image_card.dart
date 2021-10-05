import 'dart:io';
import 'package:flutter/material.dart';

class SendImageCard extends StatelessWidget {
  const SendImageCard({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          height: MediaQuery.of(context).size.height / 2.3,
          width: MediaQuery.of(context).size.width / 2.3,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.pink[100]),
          child: Card(
            margin: const EdgeInsets.all(2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Image.file(
              File(path),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
