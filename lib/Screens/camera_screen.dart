import 'package:chat_app/Screens/camera_view.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

//global variable
late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  CameraScreen({Key? key, required this.onSendImage}) : super(key: key);
  Function onSendImage;
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> _cameraValue;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.low);
    _cameraValue = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder(
              future: _cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_cameraController);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.white.withOpacity(0.5),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.flash_off, color: Colors.black, size: 30)),
                      InkWell(
                        onTap: () async {
                          try {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => CameraView(
                                        onSendImage: widget.onSendImage,
                                      )),
                            );
                          } catch (e) {
                            // If an error occurs, log the error to the console.
                            print(e);
                          }
                        },
                        child: const Icon(Icons.panorama_fish_eye, color: Colors.black, size: 50),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.flip_camera_ios_outlined, color: Colors.black, size: 30))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
