part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonState {}

class PokemonInitialState extends PokemonState {}

class PokemonLoadingState extends PokemonState {}

class PokemonLoadedState extends PokemonState {
  final List<Pokemon>? pokemon;

  Stream<List<Pokemon>?> get getPokemon async* {
    final List<Pokemon>? pokemons = [];
    for (var pok in pokemon!) {
      pokemons!.add(pok);
      yield pokemons;
    }
  }

  PokemonLoadedState({required this.pokemon});
}

class PokemonErrorState extends PokemonState {}
