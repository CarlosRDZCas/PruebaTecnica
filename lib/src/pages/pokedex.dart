import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pokemon/pokemon_bloc.dart';
import '../widgets/widgets.dart';

class Pokedex extends StatelessWidget {
  const Pokedex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'assets/images/pokeballs.png',
            fit: BoxFit.cover,
          ),
        ),
        onPressed: () {},
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .12,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 35),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  alignment: Alignment.center,
                  child: FadeInLeft(
                    duration: Duration(seconds: 1),
                    delay: Duration(milliseconds: 500),
                    child: const Text(
                      'Pokedex',
                      style: TextStyle(
                          fontFamily: 'Pokemon',
                          fontSize: 35,
                          letterSpacing: 3,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  margin: const EdgeInsets.only(top: 28),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                )
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<PokemonBloc, PokemonState>(
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
                  return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: state.pokemons.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FadeIn(
                          duration: Duration(milliseconds: 500),
                          delay: Duration(milliseconds: index * 6),
                          child: Hero(
                              tag: 'pokemon-${state.pokemons[index].id}',
                              child: FadeOut(
                                  child: CardPokemon(
                                      pokemon: state.pokemons[index]))));
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
          ),
        ],
      ),
    );
  }
}
