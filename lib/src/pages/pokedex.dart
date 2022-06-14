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
            context.read<PokemonBloc>().add(LoadPokemonEvent());

            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PokemonLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PokemonLoadedState) {
            return StreamBuilder<List<Pokemon>?>(
                stream: state.getPokemon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index].name),
                          leading: Image.network(snapshot.data![index].sprites
                              .other!.officialArtwork.frontDefault),
                        );
                      },
                    );
                  }
                  return Text('data');
                });
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
