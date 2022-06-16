part of 'selectteam_bloc.dart';

@immutable
abstract class SelectteamState {}

class SelectteamInitial extends SelectteamState {}

class SelectingState extends SelectteamState {}

class SelectedState extends SelectteamState {
  final List<String>? selectedPokemons;
  int get selectedPokemonsLength => selectedPokemons?.length ?? 0;
  final Pokemon? pokemon;
  SelectedState({this.selectedPokemons, this.pokemon});
}
