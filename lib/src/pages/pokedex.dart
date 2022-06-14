import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pokemon/pokemon_bloc.dart';

class Pokedex extends StatelessWidget {
  const Pokedex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 150,
        itemBuilder: (context, index) {
          return ListTile(
            title: BlocBuilder<PokemonBloc, PokemonState>(
              builder: (context, state) {
                context.read<PokemonBloc>().add(PokemonLoaded(index));

                return Text(state.pokemon!.name);
              },
            ),
          );
        },
      ),
    );
  }
}
