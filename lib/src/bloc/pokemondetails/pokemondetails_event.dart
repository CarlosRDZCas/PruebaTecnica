part of 'pokemondetails_bloc.dart';

@immutable
abstract class PokemondetailsEvent {}

class LoadingPokemonDetailsEvent extends PokemondetailsEvent {
  int? id;
  LoadingPokemonDetailsEvent(this.id);
}

class LoadedPokemonDetailsEvent extends PokemondetailsEvent {}

class ReinitPokemonDetailsEvent extends PokemondetailsEvent {}