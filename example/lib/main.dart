import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'camera.dart';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Toggle Flash"),
          onPressed: () async {
            final cameras = await availableCameras();
            Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) {
              return MessageCameraScreen(camera: cameras.first);
            }));
          },
        ),
      ),
    );
  }
}
