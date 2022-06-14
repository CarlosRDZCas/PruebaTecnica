part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonState {
  final Pokemon? pokemon;

  PokemonState(this.pokemon);
}

class PokemonInitial extends PokemonState {
  PokemonInitial() : super(null);
}

class PokemonLoading extends PokemonState {
  PokemonLoading(Pokemon pokemon) : super(pokemon);
}
