part of 'pokemondetails_bloc.dart';

@immutable
abstract class PokemondetailsState {}

class PokemondetailsInitial extends PokemondetailsState {}

class PokemondetailsLoadingState extends PokemondetailsState {}

class PokemondetailsLoadedState extends PokemondetailsState {
  PokemonDetails? pokemonDetails;
  PokemondetailsLoadedState({required this.pokemonDetails});
}

class PokemondetailsReinitState extends PokemondetailsState {}

class PokemondetailsErrorState extends PokemondetailsState {}
