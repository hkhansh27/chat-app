import 'package:flutter/material.dart';

class CameraView extends StatelessWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Column(
        children: <Widget>[
          const Expanded(
              child: FittedBox(
            alignment: Alignment.topLeft,
            fit: BoxFit.fill, // otherwise the logo will be tiny
            child: Image(image: AssetImage('assets/images/virtual-screen.png')),
          )),
          TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Add Captiop...",
                prefixIcon: const Icon(Icons.add_photo_alternate_sharp),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send_outlined),
                )),
          ),
        ],
      ),
    );
  }
}
