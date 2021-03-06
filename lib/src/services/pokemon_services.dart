import 'package:http/http.dart' as http;

import '../models/models.dart';

class PokemonServices {
  final String _baseUrl = 'pokeapi.co';
  List<Pokemon> list = [];
  Future<List<Pokemon>?> getPokemon() async {
    for (var i = 1; i < 151; i++) {
      final url = Uri.https(_baseUrl, '/api/v2/pokemon/$i');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        list.add(Pokemon.fromJson(response.body));
      } else {
        throw Exception('Failed to load pokemon');
      }
    }
    return list;
  }

  Future<Pokemon>? getPokemonbyID(int id) async {
    final url = Uri.https(_baseUrl, '/api/v2/pokemon/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Pokemon.fromJson(response.body);
    } else {
      throw Exception('Failed to load pokemon');
    }
  }
}
