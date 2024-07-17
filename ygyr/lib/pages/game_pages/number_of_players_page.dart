import 'package:flutter/material.dart';
import 'score_keeping_method_page.dart'; // Import the score keeping method page

class NumberOfPlayersPage extends StatefulWidget {
  final String gameName;
  final Function(String, String, int) onCreate;

  NumberOfPlayersPage({
    required this.gameName,
    required this.onCreate,
  });

  @override
  _NumberOfPlayersPageState createState() => _NumberOfPlayersPageState();
}

class _NumberOfPlayersPageState extends State<NumberOfPlayersPage> {
  final TextEditingController _playersController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Number of Players'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _playersController,
              decoration: InputDecoration(
                labelText: 'Number of Players',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_playersController.text.isNotEmpty) {
                  int players = int.parse(_playersController.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScoreKeepingMethodPage(
                        gameName: widget.gameName,
                        numberOfPlayers: players,
                        onCreate: widget.onCreate,
                      ),
                    ),
                  );
                }
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
