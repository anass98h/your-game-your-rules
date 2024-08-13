import 'package:flutter/material.dart';

class GameCreationSummaryPage extends StatelessWidget {
  final String gameName;
  final String scoreKeepingMethod;
  final int numberOfPlayers;
  final Function(String, String, int, String?, double?) onCreate; // Updated to match the full signature

  GameCreationSummaryPage({
    required this.gameName,
    required this.scoreKeepingMethod,
    required this.numberOfPlayers,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Game Creation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Game Name: $gameName',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Score Keeping Method: $scoreKeepingMethod',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Number of Players: $numberOfPlayers',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  onCreate(gameName, scoreKeepingMethod, numberOfPlayers, null, null); // Pass null for unused parameters
                  Navigator.of(context).popUntil((route) => route.isFirst); // Close this page
                },
                child: Text('Create Game'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
