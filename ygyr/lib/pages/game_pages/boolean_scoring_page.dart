import 'package:flutter/material.dart';
import 'games_page.dart'; // Ensure you import the Game model

class BooleanScoringPage extends StatefulWidget {
  final Game game;

  BooleanScoringPage({required this.game});

  @override
  _BooleanScoringPageState createState() => _BooleanScoringPageState();
}

class _BooleanScoringPageState extends State<BooleanScoringPage> {
  void _incrementScore(int index) {
    setState(() {
      widget.game.players[index].wins += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.game.title),
      ),
      body: ListView.builder(
        itemCount: widget.game.players.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => _incrementScore(index),
              child: Text('${widget.game.players[index].name}: ${widget.game.players[index].wins} Wins'),
            ),
          );
        },
      ),
    );
  }
}
