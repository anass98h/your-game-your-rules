import 'package:flutter/material.dart';
import 'game_creation_summary_page.dart'; // Ensure the import
import 'numeric_settings_page.dart'; // Ensure the import

class ScoreKeepingMethodPage extends StatelessWidget {
  final String gameName;
  final int numberOfPlayers;
  final Function(String, String, int, String?, double?) onCreate; // Update to match the required signature

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      onCreate: (String name, String method, int players, String? numericOperation, double? numericValue) {
                        onCreate(name, method, players, null, null); // Pass null for numeric params for Boolean method
                      },
                    ),
                  ),
                );
              },
              child: Text('Boolean'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NumericSettingsPage(
                      gameName: gameName,
                      numberOfPlayers: numberOfPlayers,
                      onCreate: (String name, String method, int players, String numericOperation, double numericValue) {
                        onCreate(name, method, players, numericOperation, numericValue); // Pass all arguments for Numeric
                      },
                    ),
                  ),
                );
              },
              child: Text('Numeric'),
            ),
          ],
        ),
      ),
    );
  }
}

