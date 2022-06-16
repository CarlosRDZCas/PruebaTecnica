import 'package:http/http.dart' as http;

import '../models/models.dart';

class PokemonDetailsService {
  String _baseUrl = 'pokeapi.co';

  Future<PokemonDetails>? getPokemonbyID(int id) async {
    final url = Uri.https(_baseUrl, 'api/v2/pokemon-species/${id}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(id);
      return PokemonDetails.fromJson(response.body);
    } else {
      print(id);
      throw Exception('Failed to load pokemon');
    }
  }
}
