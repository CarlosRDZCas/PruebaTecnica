part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonState {}

class PokemonInitialState extends PokemonState {}

class PokemonLoadingState extends PokemonState {}

class PokemonLoadedState extends PokemonState {
  final List<Pokemon> pokemons;
  PokemonLoadedState({required this.pokemons});
}

class PokemonErrorState extends PokemonState {}
