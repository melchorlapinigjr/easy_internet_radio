import 'package:easy_internet_radio/data/radio_stream_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'dart:async';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String radioStatTitle = "MyInternet Radio";
  int radioUrlIndex = 0;

  @override
  void initState() {
    super.initState();
    FlutterRadio.stop();
    audioStart();
    currentRadioTitle = urlStreamAddress[radioUrlIndex]['stationName'];
    radioTitle = urlStreamAddress[radioUrlIndex]['stationName'];
  }

  Future<void> audioStart() async {
    await FlutterRadio.audioStart();
    radioPlayer();
    print('Audio started.');
  }

  String currentRadioTitle;
  String radioTitle = '';
  bool isP = false;

  void radioPlayer() async {
    isP = !isP;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF14213D),
        scaffoldBackgroundColor: Color(0xFFE5E5E5),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Color(0xFF000011),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            radioStatTitle,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Icon(
                  Icons.radio,
                  size: 180,
                  color: Color(0xFF14213D),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  currentRadioTitle,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 23.0,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                Text(
                  'now playing....',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11.0,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      child: Icon(
                        Icons.arrow_left,
                        size: 80,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        setState(() {
                          radioTitle =
                              urlStreamAddress[radioUrlIndex]['stationName'];
                          radioUrlIndex == 0
                              ? radioUrlIndex = 0
                              : radioUrlIndex--;
                        });
                      },
                    ),
                    FlatButton(
                      child: Icon(
                        isP ? Icons.pause_circle_filled : Icons.play_arrow,
                        size: 80,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        setState(() {
                          isP
                              ? FlutterRadio.pause(
                                  url: urlStreamAddress[radioUrlIndex]['url'])
                              : FlutterRadio.playOrPause(
                                  url: urlStreamAddress[radioUrlIndex]['url']);

                          currentRadioTitle =
                              urlStreamAddress[radioUrlIndex]['stationName'];
                          radioPlayer();
                        });
                      },
                    ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          radioTitle =
                              urlStreamAddress[radioUrlIndex]['stationName'];
                          radioUrlIndex == urlStreamAddress.length
                              ? radioUrlIndex = 0
                              : radioUrlIndex++;
                          print('++  $radioUrlIndex ' ' $radioTitle');
                        });
                      },
                      child: Icon(
                        Icons.arrow_right,
                        size: 80,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  'Station: $radioTitle',
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
