import 'package:flutter/material.dart';

class ReceiveImageCard extends StatelessWidget {
  const ReceiveImageCard({Key? key}) : super(key: key);

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
            margin: EdgeInsets.all(2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ),
    );
  }
}
