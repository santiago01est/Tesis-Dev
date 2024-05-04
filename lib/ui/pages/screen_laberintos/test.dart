import 'package:dev_tesis/game/game_activity.dart';
import 'package:dev_tesis/game/player/player.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    final GameActivity game = GameActivity('Laberinto1');
    Player player = game.player;
    return Center(
      child: SizedBox(
        width: 800,
        height: 800,
        child: GameWidget(game: game),
      ),
    );
  }
}
