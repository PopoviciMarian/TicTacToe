import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayerVsPlayer extends StatefulWidget {
  @override
  _PlayerVsPlayerState createState() => _PlayerVsPlayerState();
}

class _PlayerVsPlayerState extends State<PlayerVsPlayer> {
  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.yellow,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
       backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Player vs Player',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow[600],
      ),
      body:Container(
         margin: EdgeInsets.fromLTRB(10, 20, 10, 120),
         

      )
    );
  }
}