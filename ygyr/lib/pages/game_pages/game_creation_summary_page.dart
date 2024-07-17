import 'package:flutter/material.dart';

class GameCreationSummaryPage extends StatelessWidget {
  final String gameName;
  final String scoreKeepingMethod;
  final int numberOfPlayers;
  final Function(String, String, int) onCreate;

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
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
          children: [
            Text(
              'Game Name:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Highlighted style
            ),
            Text(
              gameName,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Score Keeping Method:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Highlighted style
            ),
            Text(
              scoreKeepingMethod,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Number of Players:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Highlighted style
            ),
            Text(
              '$numberOfPlayers',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 32), // Add spacing before button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  onCreate(gameName, scoreKeepingMethod, numberOfPlayers);
                  Navigator.pop(context); // Pop current page
                  Navigator.pop(context); // Pop NumberOfPlayersPage
                  Navigator.pop(context); // Pop ScoreKeepingMethodPage
                  Navigator.pop(context); // Pop CreateGamePage
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
