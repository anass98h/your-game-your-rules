import 'package:flutter/material.dart';
import 'games_page.dart'; // Ensure you import the Game model

class PlayerNamingPage extends StatefulWidget {
  final Game game;
  final VoidCallback onPlayersNamed;

  PlayerNamingPage({required this.game, required this.onPlayersNamed});

  @override
  _PlayerNamingPageState createState() => _PlayerNamingPageState();
}

class _PlayerNamingPageState extends State<PlayerNamingPage> {
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.game.numberOfPlayers, (index) => TextEditingController());
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _savePlayers() {
    widget.game.players = _controllers.map((controller) => Player(controller.text, 0)).toList();
    widget.onPlayersNamed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Players'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.game.numberOfPlayers,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: _controllers[index],
                      decoration: InputDecoration(
                        labelText: 'Player ${index + 1} Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _savePlayers,
              child: Text('Save Players'),
            ),
          ],
        ),
      ),
    );
  }
}
