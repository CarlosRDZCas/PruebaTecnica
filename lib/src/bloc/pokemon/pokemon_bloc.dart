import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/pokemon_model.dart';
import '../../services/pokemon_services.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonServices _pokemonServices;
  List<Pokemon> list = [];
  PokemonBloc(this._pokemonServices) : super(PokemonInitialState()) {
    on<PokemonEvent>((event, emit) async {
      if (event is LoadingPokemonEvent) {
        emit(PokemonLoadingState());
        Pokemon? pokemon = await _pokemonServices.getPokemonbyID(event.id);
        list.add(pokemon!);
        list.sort((a, b) => a.id.compareTo(b.id));
        if (pokemon != null) {
          emit(PokemonLoadedState(pokemons: list));
        } else {
          emit(PokemonErrorState());
        }
      }
    });
  }
}
