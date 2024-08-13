import 'package:flutter/material.dart';
import 'games_page.dart'; // Ensure you import the Game model

class NumericScoringPage extends StatefulWidget {
  final Game game;

  NumericScoringPage({required this.game});

  @override
  _NumericScoringPageState createState() => _NumericScoringPageState();
}

class _NumericScoringPageState extends State<NumericScoringPage> {
  final TextEditingController _scoreController = TextEditingController();

  void _applyScore(int index) {
    if (_scoreController.text.isNotEmpty) {
      double inputScore = double.parse(_scoreController.text);
      double finalScore;

      if (widget.game.numericOperation == 'Multiplication') {
        finalScore = inputScore * widget.game.numericValue!;
      } else {
        finalScore = inputScore / widget.game.numericValue!;
      }

      setState(() {
        widget.game.players[index].wins += finalScore;
      });

      Navigator.pop(context); // Close the input dialog
    }
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
          return ListTile(
            title: Text('${widget.game.players[index].name}: ${widget.game.players[index].wins}'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Enter Score for ${widget.game.players[index].name}'),
                    content: TextField(
                      controller: _scoreController,
                      decoration: InputDecoration(
                        labelText: 'Enter Score',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () => _applyScore(index),
                        child: Text('Apply'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
