import 'package:flutter/material.dart';
import 'player_naming_page.dart';
import 'boolean_scoring_page.dart';
import 'numeric_scoring_page.dart';
import 'create_game_page.dart'; // Import the CreateGamePage file
import 'file_utils.dart'; // Import the utility functions

class Player {
  String name;
  double wins;

  Player(this.name, this.wins);
}

class Game {
  final String title;
  final String description;
  final String scoreKeepingMethod;
  final int numberOfPlayers;
  final String? numericOperation; // Can be null if not numeric
  final double? numericValue; // Can be null if not numeric
  List<Player> players = [];

  Game(this.title, this.description, this.scoreKeepingMethod, this.numberOfPlayers, {this.numericOperation, this.numericValue});
}
class GamesPage extends StatefulWidget {
  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  String _searchQuery = '';

  List<Game> games = [
    Game('Game 1', 'Description of Game 1', 'Boolean', 2),
    Game('Game 2', 'Description of Game 2','Boolean', 3),
    Game('Game 3', 'Description of Game 3', 'Boolean', 4),
  ];

  List<Game> get filteredGames {
    return games
        .where((game) =>
            game.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  // Function to add a new game
  void _addGame(String name, String method, int players, String? operation, double? value) { // Updated to accept five parameters
    setState(() {
      games.add(Game(name, 'Scorekeeping method: $method, Players: $players', method, players, numericOperation: operation, numericValue: value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GamesListPage(
      games: filteredGames,
      onSearch: (query) {
        setState(() {
          _searchQuery = query;
        });
      },
      onCreateGame: _addGame,  // Pass the function to add a game
    );
  }
}

class GamesListPage extends StatelessWidget {
  final List<Game> games;
  final Function(String) onSearch;
  final Function(String, String, int, String?, double?) onCreateGame;  // Updated to accept five parameters

  GamesListPage({
    required this.games,
    required this.onSearch,
    required this.onCreateGame,  // Initialize the callback
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Search Games',
              border: OutlineInputBorder(),
            ),
            onChanged: onSearch,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];
              return ListTile(
                title: Text(game.title),
                subtitle: Text(game.description),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameDetailsPage(game: game),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (games.isNotEmpty) {  // Example: export the first game in the list
                    await exportGame(games.first);
                  }
                },
                child: Text('Export Game'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await importGame(context, (game) {
                    // Add the imported game to the list
                    games.add(game);
                  });
                },
                child: Text('Import Game'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class GameDetailsPage extends StatelessWidget {
  final Game game;

  const GameDetailsPage({required this.game, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              game.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              game.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to PlayerNamingPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayerNamingPage(
                        game: game,
                        onPlayersNamed: () {
                          Navigator.pop(context); // Close the PlayerNamingPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                if (game.scoreKeepingMethod == 'Numeric') {
                                  return NumericScoringPage(game: game);
                                } else if (game.scoreKeepingMethod == 'Boolean') {
                                  return BooleanScoringPage(game: game);
                                }
                                return Container(); // Handle other cases or add more methods here
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                child: Text('Start Game'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
