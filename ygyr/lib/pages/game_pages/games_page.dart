import 'package:flutter/material.dart';
import 'create_game_page.dart'; // Import the CreateGamePage file

class Game {
  final String title;
  final String description;

  Game(this.title, this.description);
}

class GamesPage extends StatefulWidget {
  @override
  _GamesPageState createState() => _GamesPageState();
}
class _GamesPageState extends State<GamesPage> {
  String _searchQuery = '';

  List<Game> games = [
    Game('Game 1', 'Description of Game 1'),
    Game('Game 2', 'Description of Game 2'),
    Game('Game 3', 'Description of Game 3'),
  ];

  int _selectedIndex = 0;

  List<Game> get filteredGames {
    return games
        .where((game) =>
            game.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  List<Widget> get _widgetOptions {
    return <Widget>[
      GamesListPage(
        games: filteredGames,
        onSearch: (query) {
          setState(() {
            _searchQuery = query;
          });
        },
      ),
      Text('Players Page'), // Placeholder for Players Page
      Text('Misc Page'), // Placeholder for Misc Page
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addGame(String name, String method, int players) {
    setState(() {
      games.add(Game(name, 'Score Keeping Method: $method, Players: $players'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Games App'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Players',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'Misc',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}


class GamesListPage extends StatelessWidget {
  final List<Game> games;
  final Function(String) onSearch;

  GamesListPage({required this.games, required this.onSearch});

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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateGamePage(
                        onCreate: (String name, String method, int players) {
                          // handle game creation
                        },
                      ),
                    ),
                  );
                },
                child: Text('Create Game'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add functionality here
                },
                child: Text('Export Game'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add functionality here
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
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Games App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GamesPage(),
    );
  }
}
