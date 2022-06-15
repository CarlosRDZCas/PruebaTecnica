import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/src/models/pokemon_details_model.dart';
import 'package:pokedex/src/services/pokemon_details_service.dart';

part 'pokemondetails_event.dart';
part 'pokemondetails_state.dart';

class PokemondetailsBloc
    extends Bloc<PokemondetailsEvent, PokemondetailsState> {
  final PokemonDetailsService _pokemonDetailsServices;

  PokemondetailsBloc(this._pokemonDetailsServices)
      : super(PokemondetailsInitial()) {
    PokemonDetails? pokemonDetails;
    on<PokemondetailsEvent>((event, emit) async {
      if (event is LoadingPokemonDetailsEvent) {
        emit(PokemondetailsLoadingState());
        pokemonDetails = null;
        pokemonDetails =
            await _pokemonDetailsServices.getPokemonbyID(event.id!);
        emit(PokemondetailsLoadedState(pokemonDetails: pokemonDetails));
      }
      if (event is LoadedPokemonDetailsEvent) {}
    });
  }
}
