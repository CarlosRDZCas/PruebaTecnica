import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/src/models/pokemon_model.dart';

import '../../services/pokemon_services.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonServices _pokemonServices;

  PokemonBloc(this._pokemonServices) : super(PokemonInitial()) {
    on<PokemonLoaded>((event, emit) async {
      final pokemon = await _pokemonServices.getPokemon(event.numPokemon);
      emit(PokemonLoading(pokemon));
    });
  }
}
