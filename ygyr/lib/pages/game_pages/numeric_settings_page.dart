import 'package:flutter/material.dart';
import 'game_creation_summary_page.dart';

class NumericSettingsPage extends StatefulWidget {
  final String gameName;
  final int numberOfPlayers;
  final Function(String, String, int, String, double) onCreate;

  NumericSettingsPage({
    required this.gameName,
    required this.numberOfPlayers,
    required this.onCreate,
  });

  @override
  _NumericSettingsPageState createState() => _NumericSettingsPageState();
}

class _NumericSettingsPageState extends State<NumericSettingsPage> {
  String _operation = 'Multiplication'; // Default to Multiplication
  final TextEditingController _numberController = TextEditingController();

  void _createGame() {
    if (_numberController.text.isNotEmpty) {
      double number = double.parse(_numberController.text);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GameCreationSummaryPage(
            gameName: widget.gameName,
            scoreKeepingMethod: 'Numeric',
            numberOfPlayers: widget.numberOfPlayers,
            onCreate: (String name, String method, int players, String? numericOperation, double? numericValue) {
              widget.onCreate(name, method, players, _operation, number);
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Numeric Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: _operation,
              onChanged: (String? newValue) {
                setState(() {
                  _operation = newValue!;
                });
              },
              items: <String>['Multiplication', 'Division']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _numberController,
              decoration: InputDecoration(
                labelText: 'Enter Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createGame,
              child: Text('Create Game'),
            ),
          ],
        ),
      ),
    );
  }
}
