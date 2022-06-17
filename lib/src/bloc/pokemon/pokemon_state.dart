part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonState {}

class PokemonInitialState extends PokemonState {}

class PokemonLoadingState extends PokemonState {}

class PokemonLoadedState extends PokemonState {
  final List<Pokemon>? pokemons;
  Stream<List<Pokemon>?> get pokemonsStream async* {
    yield pokemons;
  }

  PokemonLoadedState({required this.pokemons});
}

class PokemonErrorState extends PokemonState {}
