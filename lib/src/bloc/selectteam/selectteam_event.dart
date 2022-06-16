part of 'selectteam_bloc.dart';

@immutable
abstract class SelectteamEvent {}

class SelectteamEventInitial extends SelectteamEvent {
  final Pokemon? pokemon;
  SelectteamEventInitial({this.pokemon});
}

class SelectingteamEvent extends SelectteamEvent {
  final String name;
  SelectingteamEvent(this.name);
}

class SelectedPokemonEvent extends SelectteamEvent {}
