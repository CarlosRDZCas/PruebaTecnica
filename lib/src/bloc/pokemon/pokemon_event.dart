part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent {}

class LoadPokemonEvent extends PokemonEvent {}

class LoadingPokemonEvent extends PokemonEvent {
  int? id;
  LoadingPokemonEvent(this.id);
}
