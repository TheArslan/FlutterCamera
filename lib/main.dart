import 'dart:io';

import 'package:flutter/material.dart';
import 'package:drivertube/shapespainter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weather/weather.dart';

WeatherStation weatherStation =
    new WeatherStation("0b2ad730cce3aae6cc1d29acfd645aa3");
Weather weather;
double celsius;
Future<void> main() async {
  runApp(MyApp());
  weather = await weatherStation.currentWeather();
  celsius = weather.temperature.celsius;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DriverTube',
      routes: <String, WidgetBuilder>{
        '/camera': (BuildContext context) => Camerashow(celsius),
        '/home': (BuildContext context) => MyHomePage(),
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.navigate_before),
          onPressed: () {},
        ),
        title: Text(
          "Post",
          style: TextStyle(color: Color(0xFF1ED761)),
        ),
        backgroundColor: Color(0xFF242A37),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF242A37),
      body: Stack(
        children: <Widget>[
          Container(),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 400,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(10.0),
                    width: 400,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Color(0xFF242A37),
                        border: Border.all(color: Color(0xFF242A37), width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.black,
                            offset: new Offset(05.0, 05.0),
                            blurRadius: 05.0,
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            //    ImageIcon(new
                            //    AssetImage('icons/hello.png'),size: 05.0,),

                            Icon(
                              Icons.toc,
                              color: Color(0xFF1ED761),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(11, 0, 0, 0),
                                child: Text("Category",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.0)))
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(35.0, 10.0, 0, 0),
                            child: Text(
                              "Not Selected",
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    padding: EdgeInsets.all(10.0),
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFF242A37),
                      border: Border.all(color: Color(0xFF1ED761), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        counterStyle: TextStyle(color: Color(0xFF4E586E)),
                        hintText: "Add Title(Max 40)",
                        hintStyle:
                            TextStyle(color: Color(0xFF4E586E), fontSize: 20.0),
                      ),
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                      maxLength: 40,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    padding: EdgeInsets.all(5.0),
                    width: 400,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Color(0xFF242A37),
                      border: Border.all(color: Color(0xFF1ED761), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        counterStyle: TextStyle(color: Color(0xFF4E586E)),
                        hintText: "Add Description(Max 150)",
                        hintStyle:
                            TextStyle(color: Color(0xFF4E586E), fontSize: 20.0),
                      ),
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                      maxLength: 150,
                      maxLines: 5,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            children: <Widget>[
                              ImageIcon(
                                AssetImage("assets/hello.png"),
                                color: Color(0xFF1ED761),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Post Anonymously",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          // padding: EdgeInsets.only(left: 80.0),
                          child: Container(
                            width: 60.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF242A37),
                              border: Border.all(
                                  color: Color(0xFF1ED761), width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Switch(
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                });
                              },
                              activeTrackColor: Colors.lightGreenAccent,
                              activeColor: Colors.green,
                              inactiveTrackColor: Color(0xFF242A37),
                              inactiveThumbColor: Color(0xFF1ED761),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 170,
              child: Column(
                
                children: <Widget>[
                  SizedBox(
                    width: 400.0,
                    height: 50.0,
                    child: FlatButton(
                      child: Text(
                        'Post',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color(0xFF1ED761),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 05.0),
                    child: SizedBox(
                      width: 400.0,
                      height: 50.0,
                      child: OutlineButton(
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Color(0xFF1ED761)),
                          ),
                          borderSide: BorderSide(color: Color(0xFF1ED761)),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/camera', (Route<dynamic> route) => false);
                          }),
                    ),
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
