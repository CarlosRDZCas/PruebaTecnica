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
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 20,
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.white,
        title: FadeInLeft(
          child: const Text(
            'Pokedex',
            style: TextStyle(
                fontFamily: 'Pokemon',
                fontSize: 35,
                letterSpacing: 3,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      endDrawer: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoadedState) {
            return CustomDrawer(pokemons: state.pokemons);
          }
          return const Drawer();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const CustomFAB(),
      body: Column(
        children: const [
          CardsGenerator(),
        ],
      ),
    );
  }
}

class CustomFAB extends StatelessWidget {
  const CustomFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        return FadeInUp(
          child: FloatingActionButton(
            backgroundColor: Colors.blueGrey,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                'assets/images/pokeballs.png',
                fit: BoxFit.cover,
              ),
            ),
            onPressed: () {
              if (state is PokemonLoadedState) {
                Navigator.pushNamed(context, '/selectteam',
                    arguments: state.pokemons);
              }
            },
          ),
        );
      },
    );
  }
}

class CardsGenerator extends StatelessWidget {
  const CardsGenerator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    return Expanded(
      child: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonInitialState) {
            for (var i = 1; i < 151; i++) {
              context.read<PokemonBloc>().add(LoadingPokemonEvent(i));
            }
            return Center(
              child: Image.asset(
                'assets/images/pokeballwingle.gif',
              ),
            );
          } else if (state is PokemonLoadingState) {
            return Center(
              child: Image.asset(
                'assets/images/pokeballwingle.gif',
              ),
            );
          } else if (state is PokemonLoadedState) {
            state.pokemons!.sort((a, b) => a.id.compareTo(b.id));
            return GridView.builder(
              // controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: state.pokemons!.length,
              itemBuilder: (BuildContext context, int index) {
                return SlideInLeft(
                    duration: const Duration(milliseconds: 200),
                    child: Hero(
                        tag: 'pokemon-${state.pokemons![index].id}',
                        child: FadeOut(
                            child: CardPokemon(
                          pokemon: state.pokemons![index],
                        ))));
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
