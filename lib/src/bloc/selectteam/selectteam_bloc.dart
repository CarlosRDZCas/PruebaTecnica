import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/models.dart';

part 'selectteam_event.dart';
part 'selectteam_state.dart';

class SelectteamBloc extends Bloc<SelectteamEvent, SelectteamState> {
  SelectteamBloc() : super(SelectteamInitial()) {
    List<String> selectedPokemons = [];

    on<SelectteamEvent>((event, emit) {
      if (event is SelectteamEventInitial) {
        emit(SelectedState(pokemon: event.pokemon));
      }
      if (event is SelectingteamEvent) {
        emit(SelectingState());
        if (selectedPokemons.contains(event.name)) {
          selectedPokemons.remove(event.name);
          emit(SelectedState(selectedPokemons: selectedPokemons));
        } else {
          selectedPokemons.length < 6
              ? selectedPokemons.add(event.name)
              : selectedPokemons;
          emit(SelectedState(selectedPokemons: selectedPokemons));
        }
      }
    });
  }
}
