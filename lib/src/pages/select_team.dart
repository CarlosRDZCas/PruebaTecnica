import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/src/widgets/pokemon_card.dart';

import '../bloc/selectteam/selectteam_bloc.dart';
import '../models/models.dart';

class SelectTeam extends StatelessWidget {
  const SelectTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemons =
        ModalRoute.of(context)!.settings.arguments as List<Pokemon>;
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<SelectteamBloc, SelectteamState>(
          builder: (context, state) {
            if (state is SelectedState) {
              return FadeInDown(
                child: Text(
                    '${state.selectedPokemonsLength} Pokemon(s) seleccionados',
                    style: TextStyle(
                        fontFamily: 'Pokemon',
                        letterSpacing: 1.8,
                        fontSize: 15)),
              );
            }
            return Text('Selecciona tu equipo',
                style: TextStyle(fontFamily: 'Pokemon'));
          },
        ),
        backgroundColor: Colors.white.withOpacity(0.0),
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: GridView.builder(
          physics: BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: pokemons.length,
          itemBuilder: (BuildContext context, int index) {
            return SlideInLeft(
              child: Hero(
                tag: 'pokemon-${pokemons[index].id}',
                child: CardPokemon(
                  pokemon: pokemons[index],
                  selectable: true,
                  pantalla: 'Equipo',
                ),
              ),
            );
          }),
    );
  }
}
