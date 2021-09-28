import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

//global variable
late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;

  @override
  void initState() {
    _cameraController = CameraController(cameras[0], ResolutionPreset.low);
    cameraValue = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
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
                        onTap: () {},
                        child: const Icon(Icons.panorama_fish_eye, color: Colors.black, size: 50),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.flip_camera_ios_outlined, color: Colors.black, size: 30))
                    ],
                  ),
                  const Text("Hold for video, tap for photo")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
