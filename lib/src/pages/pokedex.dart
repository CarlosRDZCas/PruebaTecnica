import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pokemon/pokemon_bloc.dart';
import '../models/pokemon_model.dart';

class Pokedex extends StatelessWidget {
  const Pokedex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonInitialState) {
            for (var i = 1; i < 151; i++) {
              context.read<PokemonBloc>().add(LoadingPokemonEvent(i));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PokemonLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PokemonLoadedState) {
            state.pokemons.sort((a, b) => a.id.compareTo(b.id));
            return ListView.builder(
              itemCount: state.pokemons.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.pokemons[index].name),
                  leading: Image.network(state.pokemons[index].sprites.other!
                      .officialArtwork.frontDefault),
                );
              },
            );
          } else if (state is PokemonErrorState) {
            return const Center(
              child: Text('Error'),
            );
          }
          return const Center(
            child: Text('Error'),
          );
        },
      ),
    );
  }
}
