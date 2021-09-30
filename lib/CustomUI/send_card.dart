import 'package:flutter/material.dart';

class SendCard extends StatelessWidget {
  const SendCard({Key? key}) : super(key: key);

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
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 30, top: 10, bottom: 20),
                child: Text(
                  "HihihihihihiHihihihihihiHihihihihihiHihihihihihiHihihihihihiHihihihihihiHihihihihihiHihihihihihiHihihihihihiHihihihihihiHihihihihihiHihihihihihiHihihihihihi",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Positioned(
                  bottom: 4,
                  right: 10,
                  child: Row(children: const [
                    Text(
                      "9:03",
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.done,
                      size: 13,
                    )
                  ]))
            ])),
      ),
    );
  }
}
