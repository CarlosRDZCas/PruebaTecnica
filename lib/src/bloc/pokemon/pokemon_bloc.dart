import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/pokemon_model.dart';
import '../../services/pokemon_services.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonServices _pokemonServices;
  PokemonBloc(this._pokemonServices) : super(PokemonInitialState()) {
    on<PokemonEvent>((event, emit) async {
      if (event is LoadPokemonEvent) {
        emit(PokemonLoadingState());
        List<Pokemon>? pokemon = await _pokemonServices.getPokemon();
        if (pokemon != null) {
          emit(PokemonLoadedState(pokemon: pokemon));
        } else {
          emit(PokemonErrorState());
        }
      }
    });
  }
}
