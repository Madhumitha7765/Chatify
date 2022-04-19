// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, avoid_unnecessary_containers, await_only_futures, unused_local_variable, avoid_print

import 'dart:math';

import 'package:camera/camera.dart';
import 'package:chat_app/Screens/CameraView.dart';
import 'package:chat_app/Screens/VideoView.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

List<CameraDescription> cameras = [];

class CameraScreen extends StatefulWidget {
  CameraScreen({required this.onImageSend});
  final Function onImageSend;

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  bool isRecording = false;
  bool flash = false;
  bool isCameraFront = true;
  double transform = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraController = CameraController(
      cameras[0],
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      } else {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cameraController.dispose();
  }

  void takePhoto(BuildContext context) async {
    final tempPath = await getTemporaryDirectory();
    final path = join(tempPath.path, "${DateTime.now()}.png");
    XFile picture = await _cameraController.takePicture();
    picture.saveTo(path);
    // String filePath =  picture.path;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (builder) {
        return CameraViewPage(
          onImageSend: widget.onImageSend,
          path: path,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Material(
        child: Stack(
          children: [
            Container(
              child: CameraPreview(_cameraController),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      color: Colors.black,
                      height: 30,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              flash = !flash;
                            });
                            flash
                                ? _cameraController
                                    .setFlashMode(FlashMode.torch)
                                : _cameraController.setFlashMode(FlashMode.off);
                          },
                          icon: Icon(
                            flash ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        GestureDetector(
                          onLongPress: () async {
                            await _cameraController.startVideoRecording();
                            setState(() {
                              isRecording = true;
                            });
                          },
                          onLongPressUp: () async {
                            final tempPath = await getTemporaryDirectory();
                            final videoPath =
                                join(tempPath.path, "${DateTime.now()}.mp4");
                            XFile videoFile =
                                await _cameraController.stopVideoRecording();
                            videoFile.saveTo(videoPath);
                            print(videoFile.path);
                            setState(() {
                              isRecording = false;
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (builder) {
                                return VideoViewPage(
                                  path: videoPath,
                                );
                              }),
                            );
                          },
                          onTap: () {
                            if (!isRecording) {
                              takePhoto(context);
                            }
                          },
                          child: isRecording
                              ? Icon(
                                  Icons.radio_button_on,
                                  size: 70,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.panorama_fish_eye,
                                  color: Colors.white,
                                  size: 70,
                                ),
                        ),
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              isCameraFront = !isCameraFront;
                              transform = transform + (pi);
                            });

                            int cameraPos = isCameraFront ? 0 : 1;
                            _cameraController = CameraController(
                              cameras[cameraPos],
                              ResolutionPreset.medium,
                              imageFormatGroup: ImageFormatGroup.yuv420,
                            );
                            _cameraController.initialize().then((_) {
                              if (!mounted) {
                                return;
                              } else {
                                setState(() {});
                              }
                            });
                          },
                          icon: Transform.rotate(
                            angle: transform,
                            child: Icon(
                              Icons.flip_camera_ios,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Hold for Video, tap for photo",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
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
}




// List<CameraDescription> cameras = [];

// class CameraScreen extends StatefulWidget {
//   const CameraScreen({Key? key}) : super(key: key);

//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   late CameraController _cameraController;
//   XFile? pictureFile;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _cameraController = CameraController(cameras[0], ResolutionPreset.high,
//         imageFormatGroup: ImageFormatGroup.yuv420);
//     _cameraController.initialize().then((_) {
//       if (!mounted) {
//         return;
//       } else {
//         setState(() {});
//       }
//     });
//   }

//   // @override
//   // void dispose() {
//   //   // TODO: implement dispose
//   //   super.dispose();
//   //   _cameraController.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         FutureBuilder(
//             future: _cameraController.initialize(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 print("Initialized");
//                 return CameraPreview(_cameraController);
//               } else {
//                 print("Error");
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             }),
//         Positioned(
//           bottom: 0.0,
//           child: Container(
//             padding: EdgeInsets.only(top: 5, bottom: 5),
//             color: Colors.black,
//             width: MediaQuery.of(context).size.width,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.flash_off,
//                         color: Colors.white,
//                         size: 28,
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {},
//                       child: Icon(
//                         Icons.panorama_fish_eye,
//                         color: Colors.white,
//                         size: 70,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.flip_camera_ios,
//                         color: Colors.white,
//                         size: 28,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 Text(
//                   "Hold for Video, tap for photo",
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   // void takePhoto() async {
//   //   final tempPath = await getTemporaryDirectory();
//   //   final path1 = join(tempPath.path, "${DateTime.now()}.png");
//   //   await _cameraController.takePicture(path1);
//   // }
// }
