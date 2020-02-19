import 'package:flutter/material.dart';
import 'package:tic_tac_toe/pages/player_vs_player.dart';
import 'pages/home.dart';
import 'pages/player_vs_player.dart';
import 'pages/player_vs_ai.dart';
import 'pages/meniu_player_vs_ai.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/player_vs_ai',
      routes: {
        '/meniu_player_vs_ai': (context) => Meniu_Ai(),
        '/home': (context) => Home(),
        '/player_vs_player':(context) => PlayerVsPlayer(),
        '/player_vs_ai':(context) => PlayerVsAi(),
      },
));
