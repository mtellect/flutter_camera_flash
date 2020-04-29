import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class MessageCameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const MessageCameraScreen({Key key, this.camera}) : super(key: key);

  @override
  MessageCameraScreenState createState() => MessageCameraScreenState();
}

class MessageCameraScreenState extends State<MessageCameraScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();

  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: <Widget>[
                CameraPreview(_controller),
                Positioned(
                  top: screenWidth / 17 + 10,
                  left: screenWidth / 17,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: Colors.white, size: screenWidth / 12.5),
                  ),
                ),
                Positioned(
                  top: screenWidth / 17 + 10,
                  right: screenWidth / 17,
                  child: IconButton(
                    onPressed: () async {
                      print(_isFlashOn);
                      if (_isFlashOn) {
                        await _controller.turnOffFlash();
                      } else {
                        await _controller.turnOnFlash();
                      }
                      _isFlashOn = !_isFlashOn;
                    },
                    icon: Icon(Icons.flash_on, color: Colors.white, size: screenWidth / 12.5),
                  ),
                ),
                Positioned(
                  bottom: screenWidth / 17 + 10,
                  left: screenWidth / 17,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.photo, color: Colors.white, size: screenWidth / 12.5),
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

}