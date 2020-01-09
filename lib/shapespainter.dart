import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:drivertube/cameraButton.dart';
import 'package:drivertube/distancewidget.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'date_utils.dart';
import 'flashBlock.dart';

enum FlashState { Flash_OFF, Flash_On, Flash_Auto }

class Camerashow extends StatefulWidget {
  double value;
  Camerashow(this.value);

  @override
  _CamerashowState createState() => _CamerashowState(value);
}

class _CamerashowState extends State<Camerashow> {
  
  final IconBlock _iconBlock = IconBlock();
  DateTime selecteddate = DateTime.now();
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  double c=0.0;
  _CamerashowState(this.c);

  CameraController controller;
  String videoPath;
  List<CameraDescription> cameras;
  int selectedCameraIdx;
  double celsius;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void initState() {
    super.initState();

    // celsius=22.0;

    // Get the listonNewCameraSelected of available cameras.
    // Then set the first camera as selected.
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      
      if (cameras.length > 0) {
        setState(() {
          selectedCameraIdx = 0;
        });

        controller = CameraController(cameras[0], ResolutionPreset.ultraHigh);
        controller.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  @override
  void dispose() {
    _iconBlock.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                  child: Center(
                child: _cameraPreviewWidget(),
              )),
            )
          ],
        ),
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: Container(
        child: Stack(
          children: <Widget>[
            CameraPreview(controller),
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 180.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        alignment: Alignment.topLeft,
                        icon: ImageIcon(
                          
                          AssetImage('assets/close.png'),
                          color: Colors.white,
                          
                        ),
                        onPressed: (){
                          dispose();
                          Navigator.of(context).pushNamedAndRemoveUntil( '/home',(Route<dynamic> route)=>false);

                        }
                        
                        
                      /*  controller != null &&
                                controller.value.isInitialized &&
                                controller.value.isRecordingVideo
                            ? _onStopButtonPressed
                            : null,
                            */
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            width: 180,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(00, 00, 00, 0.3),
                              // border: Border.all( width: 3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            // alignment: Alignment.bottomCenter,
                            //   margin: EdgeInsets.only(top: 35.0),
                            //      width: 200.0,
                            //    height: 80.0,
                            //  color: Color.fromRGBO(00, 00, 00, 0.7),
                            // decoration: BoxDecoration(
                            // border: Border.all(color: Color(0xFF242A37), width: 3),
                            // borderRadius: BorderRadius.all(Radius.circular(10)),
                            //  ),
                          ),
                          //  Padding(padding: EdgeInsets.only(top: 5),),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(00, 00, 00, 0.3),
                              // border: Border.all( width: 3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            // alignment: Alignment.bottomCenter,
                            //   margin: EdgeInsets.only(top: 35.0),
                            //      width: 200.0,
                            //    height: 80.0,
                            //  color: Color.fromRGBO(00, 00, 00, 0.7),
                            // decoration: BoxDecoration(
                            // border: Border.all(color: Color(0xFF242A37), width: 3),
                            // borderRadius: BorderRadius.all(Radius.circular(10)),
                            //  ),
                            child: Text(
                              "California Street",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(00, 00, 00, 0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Row(
                              children: <Widget>[
                                ImageIcon(
                                  AssetImage("assets/weather.png"),
                                  color: Colors.white,
                                ),
                                Text(
                                  c.toStringAsFixed(0) + "\u2103",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                         DistanceWidget(),

                        /* 
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(300),
                              ),
                              border: Border.all(color: Colors.red, width: 3),
                            ),
                            child: Column(
                              children: <Widget>[
                                Text("70"),
                                Text("Km/hr"),
                              ],
                            ),
                          )

                          */
                        ],
                      ),
                    ],
                  ),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120.0,
                margin: EdgeInsets.only(bottom: 20),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        
                        children: <Widget>[
                          StreamBuilder<Icon>(
                              stream: _iconBlock.iconStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<Icon> snapshot) {
                                return Container(
                                  child: IconButton(
                                      icon: snapshot.data,
                                      color: Colors.white,
                                      onPressed: () {
                                        _iconBlock.iconsink.add(snapshot.data);
                                      }),
                                );
                              }),
                              Padding(padding: EdgeInsets.only(left: 20),child: Text("0:17 / 1:00",style: TextStyle(color: Colors.white),),)
                              
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CameraButton(),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(00, 00, 00, 0.3),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Text(
                         formatterDate.format(selecteddate) + " " +
                          formatter.format(selecteddate),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
            /*   Container(
              decoration: BoxDecoration(
                color: Colors.white
              ),
              margin: EdgeInsets.only(top: 35.0),
              //padding: EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: ImageIcon(
                      AssetImage('assets/close.png'),
                      color: Colors.white,
                    ),
                    onPressed: controller != null &&
                            controller.value.isInitialized &&
                            controller.value.isRecordingVideo
                        ? _onStopButtonPressed
                        : null,
                  ),
                  //Padding(padding: EdgeInsets.only(right: 20.0),),
                  Container(
                      alignment: Alignment.bottomCenter,
                      //   margin: EdgeInsets.only(top: 35.0),
                      width: 200.0,
                      height: 150.0,
                      color: Color.fromRGBO(00, 00, 00, 0.7)),
                  Column(
                    
                    children: <Widget>[
                      Container(
                        
                        //  margin: EdgeInsets.only(top: 35.0),
                        padding: EdgeInsets.all(8.0),
                        width: 70.0,
                        height: 30.0,
                        color: Color.fromRGBO(00, 00, 00, 0.7),
                        child: Row(
                          children: <Widget>[
                            ImageIcon(
                              AssetImage("assets/weather.png"),
                              color: Colors.white,
                            ),
                            Text(
                              c.toStringAsFixed(0)+"\u2103",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),




            */

            /*
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 120.0,
                padding: EdgeInsets.all(20.0),
                color: Color.fromRGBO(00, 00, 00, 0.7),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Material(
                        color: Colors.transparent,
                        child: Listener(
                          onPointerDown: (details) {
                            if (controller != null &&
                                controller.value.isInitialized &&
                                !controller.value.isRecordingVideo) {
                              _onRecordButtonPressed();
                            } else {}
                          },
                          onPointerUp: (details) {
                            if (controller != null &&
                                controller.value.isInitialized &&
                                !controller.value.isRecordingVideo) {
                              _onStopButtonPressed();
                            } else {}
                          },
                          child: InkWell(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            /* onTap: controller != null &&
                                    controller.value.isInitialized &&
                                    !controller.value.isRecordingVideo
                                ? _onRecordButtonPressed
                                : null,
                            onDoubleTap: controller != null &&
                                    controller.value.isInitialized &&
                                    controller.value.isRecordingVideo
                                ? _onStopButtonPressed
                                : null,
                                */
                            child: Container(
                              padding: EdgeInsets.all(4.0),
                              child: Image.asset(
                                'assets/ellipsehollow.png',
                                width: 72.0,
                                height: 72.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            */
          ],
        ),
      ),
    );
  }

  void _onRecordButtonPressed() {
    _startVideoRecording().then((String filePath) {
      if (filePath != null) {
        Fluttertoast.showToast(
            msg: 'Recording video started',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white);
      }
    });
  }

  Future<String> _startVideoRecording() async {
    if (!controller.value.isInitialized) {
      Fluttertoast.showToast(
          msg: 'Please wait',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white);

      return null;
    }

    // Do nothing if a recording is on progress
    if (controller.value.isRecordingVideo) {
      return null;
    }

    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final String videoDirectory = '${appDirectory.path}/Videos';
    await Directory(videoDirectory).create(recursive: true);
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath = '$videoDirectory/${currentTime}.mp4';

    try {
      await controller.startVideoRecording(filePath);
      videoPath = filePath;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    return filePath;
  }

  void _showCameraException(CameraException e) {
    String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    print(errorText);

    Fluttertoast.showToast(
        msg: 'Error: ${e.code}\n${e.description}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  void _onStopButtonPressed() {
    _stopVideoRecording().then((_) {
      if (mounted) setState(() {});
      Fluttertoast.showToast(
          msg: 'Video recorded to $videoPath',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white);
    });
  }

  Future<void> _stopVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }
}
