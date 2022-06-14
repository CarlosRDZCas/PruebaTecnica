part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent {}

class PokemonLoaded extends PokemonEvent {
  final int numPokemon;

  PokemonLoaded(this.numPokemon);
}
