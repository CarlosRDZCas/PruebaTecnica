import 'dart:convert';

import '../models/pokemon_model.dart';
import 'package:http/http.dart' as http;

class PokemonServices {
  String _baseUrl = 'pokeapi.co';

  Future<Pokemon> getPokemon(int id) async {
    final url = Uri.https(_baseUrl, '/api/v2/pokemon/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Pokemon.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load pokemon');
    }
  }
}
