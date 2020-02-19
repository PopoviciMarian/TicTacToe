import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.yellow,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Tic Tac Toe',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow[600],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/img_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 150, 0, 250),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 250,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/meniu_player_vs_ai');
                  },
                  child: const Text('Player vs AI',                                                                                                             
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                          letterSpacing: 1.8)),
                  color: Colors.yellow[500],
                ),
              ),
              SizedBox(
                width: 250,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/player_vs_player');
                  },
                  child: const Text('Player vs Player',
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                          letterSpacing: 1.8)),
                  color: Colors.yellow[500],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
