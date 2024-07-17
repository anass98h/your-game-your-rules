import 'package:flutter/material.dart';
import 'game_creation_summary_page.dart'; // Ensure the import

class ScoreKeepingMethodPage extends StatelessWidget {
  final String gameName;
  final int numberOfPlayers;
  final Function(String, String, int) onCreate;

  ScoreKeepingMethodPage({
    required this.gameName,
    required this.numberOfPlayers,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Score Keeping Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch to full width
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameCreationSummaryPage(
                      gameName: gameName,
                      scoreKeepingMethod: 'Boolean',
                      numberOfPlayers: numberOfPlayers,
                      onCreate: onCreate, // Pass the onCreate callback
                    ),
                  ),
                );
              },
              child: Text('Boolean'),
            ),
            SizedBox(height: 16), // Add spacing between buttons
            ElevatedButton(
              onPressed: () {
                // Implement navigation for Numeric
              },
              child: Text('Numeric'),
            ),
            SizedBox(height: 16), // Add spacing between buttons
            ElevatedButton(
              onPressed: () {
                // Implement navigation for Buttons
              },
              child: Text('Buttons'),
            ),
          ],
        ),
      ),
    );
  }
}
