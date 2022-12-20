import 'package:flutter/material.dart';

class CameraView extends StatelessWidget {
  CameraView({Key? key, required this.onSendImage}) : super(key: key);
  Function onSendImage;
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Column(
        children: <Widget>[
          const Expanded(
              child: Image(
            image: AssetImage('assets/images/virtual-screen.png'),
          )
              // 'assets/images/virtual-screen.png'
              ),
          TextFormField(
            controller: _textEditingController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Add Captiop...",
                prefixIcon: const Icon(Icons.add_photo_alternate_sharp),
                suffixIcon: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.send_outlined),
                )),
          ),
        ],
      ),
    );
  }
}
