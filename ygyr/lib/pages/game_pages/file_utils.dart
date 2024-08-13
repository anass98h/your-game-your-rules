import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'games_page.dart'; // Import the Game model

Future<void> exportGame(Game game) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/${game.title}.json');
  
  final jsonString = jsonEncode({
    'title': game.title,
    'description': game.description,
    'scoreKeepingMethod': game.scoreKeepingMethod,
    'numberOfPlayers': game.numberOfPlayers,
    'numericOperation': game.numericOperation,
    'numericValue': game.numericValue,
  });
  
  await file.writeAsString(jsonString);
}

Future<void> importGame(BuildContext context, Function(Game) addGameToList) async {
  final result = await FilePicker.platform.pickFiles(type: FileType.any);
  
  if (result != null) {
    final file = File(result.files.single.path!);
    final jsonString = await file.readAsString();
    final data = jsonDecode(jsonString);
    
    final game = Game(
      data['title'],
      data['description'],
      data['scoreKeepingMethod'],
      data['numberOfPlayers'],
      numericOperation: data['numericOperation'],
      numericValue: data['numericValue'],
    );
    
    addGameToList(game);  // Add the game to the list in your UI
  }
}
