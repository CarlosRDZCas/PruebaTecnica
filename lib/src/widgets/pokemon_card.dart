import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pokemondetails/pokemondetails_bloc.dart';
import '../bloc/selectteam/selectteam_bloc.dart';
import '../models/pokemon_model.dart';

class CardPokemon extends StatelessWidget {
  final Pokemon? pokemon;
  final String? pantalla;
  final bool? selectable;

  const CardPokemon(
      {Key? key, required this.pokemon, this.pantalla, this.selectable = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return selectable == true
        ? BlocBuilder<SelectteamBloc, SelectteamState>(
            builder: (context, state) {
              if (state is SelectteamInitial) {
                context
                    .read<SelectteamBloc>()
                    .add(SelectteamEventInitial(pokemon: pokemon));
              }
              if (state is SelectedState) {
                return Material(
                  child: InkWell(
                    onTap: () {
                      context
                          .read<SelectteamBloc>()
                          .add(SelectingteamEvent(pokemon!.name));

                      if (state is SelectingState) {
                        context
                            .read<SelectteamBloc>()
                            .add(SelectedPokemonEvent());
                      }
                    },
                    child: CardBody(
                      pantalla: pantalla,
                      pokemon: pokemon,
                      pokemons: state.selectedPokemons,
                    ),
                  ),
                );
              }
              return Container();
            },
          )
        : BlocBuilder<PokemondetailsBloc, PokemondetailsState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  if (pantalla == 'details') {
                  } else {
                    context.read<PokemondetailsBloc>().add(
                          ReinitPokemonDetailsEvent(),
                        );
                    Navigator.pushNamed(context, '/pokemondetails',
                        arguments: pokemon);
                  }
                },
                child: CardBody(pantalla: pantalla, pokemon: pokemon),
              );
            },
          );
  }
}

class CardBody extends StatelessWidget {
  const CardBody({
    Key? key,
    required this.pantalla,
    required this.pokemon,
    this.pokemons,
  }) : super(key: key);
  final List<String>? pokemons;
  final String? pantalla;
  final Pokemon? pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: pantalla == 'details'
          ? const EdgeInsets.only(top: 45, left: 30, right: 30, bottom: 35)
          : const EdgeInsets.all(0),
      margin: pantalla == 'details'
          ? const EdgeInsets.all(0)
          : pantalla == 'Equipo'
              ? pokemons != null && pokemons!.contains(pokemon!.name)
                  ? const EdgeInsets.all(5)
                  : const EdgeInsets.all(15)
              : const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: pantalla == 'details'
            ? BorderRadius.circular(0)
            : BorderRadius.circular(10),
        color: pantalla == 'Equipo'
            ? pokemons != null && pokemons!.contains(pokemon!.name)
                ? _selectColor(pokemon!.types[0].type.name)
                : Colors.grey.withOpacity(0.5)
            : _selectColor(pokemon!.types[0].type.name),
      ),
      height: 50,
      width: 50,
      child: Stack(
        children: [
          Positioned(
            bottom: pantalla == 'details' ? -10 : -30,
            right: pantalla == 'details' ? -60 : -80,
            child: Container(
              height: pantalla == 'details' ? 200 : 160,
              width: pantalla == 'details' ? 320 : 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                'assets/images/pokeball.png',
                fit: BoxFit.fill,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          Positioned(
            top: pantalla == 'details' ? 40 : 30,
            left: 8,
            child:
                SizedBox(height: 20, width: 150, child: _tipos(pokemon!.types)),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Text(
                  pokemon!.name.capitalize(),
                  style: TextStyle(
                      letterSpacing: 3,
                      fontSize: pantalla == 'details' ? 20 : 15,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Pokemon',
                      color: Colors.white),
                ),
                const Spacer(),
                Text(
                  pokemon!.id < 10
                      ? '#00${pokemon!.id}'
                      : pokemon!.id < 100
                          ? '#0${pokemon!.id}'
                          : '#${pokemon!.id}',
                  style: const TextStyle(
                      letterSpacing: 3,
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Pokemon',
                      color: Colors.white70),
                ),
              ],
            ),
          ),
          Positioned(
            right: pantalla == 'details' ? 40 : 0,
            bottom: pantalla == 'details' ? -10 : 0,
            child: SizedBox(
              height: pantalla == 'details' ? 200 : 130,
              width: pantalla == 'details' ? 200 : 130,
              child: Image.network(
                pokemon!.sprites.other!.officialArtwork.frontDefault,
                fit: BoxFit.fill,
                filterQuality: FilterQuality.low,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color? _selectColor(String tipo) {
    switch (tipo) {
      case 'steel':
        return const Color(0xffA6A6B7);
      case 'ghost':
        return const Color(0xff6E6EBF);
      case 'normal':
        return const Color(0xffBCB4AC);
      case 'fire':
        return const Color(0xffE65B40);
      case 'water':
        return const Color(0xff3399FF);
      case 'electric':
        return const Color(0xffFDCC3A);
      case 'grass':
        return const Color(0xff74C753);
      case 'ice':
        return const Color(0xff80DCFB);
      case 'psychic':
        return const Color(0xffFF87B1);
      case 'fighting':
        return const Color(0xffBB5544);
      case 'rock':
        return const Color(0xffBBAA66);
      case 'dark':
        return const Color(0xff5E4E3C);
      case 'poison':
        return const Color(0xff934D82);
      case 'ground':
        return const Color(0xffDDBB55);
      case 'flying':
        return const Color(0xff934D82);
      case 'bug':
        return const Color(0xffCEDA69);
      case 'fairy':
        return const Color(0xffFCABFF);
      case 'dragon':
        return const Color(0xff6B4EB2);
      default:
        return const Color(0xffBCB4AC);
    }
  }
}

Widget _tipos(List<Type> tipo) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: tipo.length,
    physics: const NeverScrollableScrollPhysics(),
    scrollDirection: Axis.horizontal,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white30,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: Text(
              tipo[index].type.name.capitalize(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 9,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w100,
                  fontFamily: 'Pokemon',
                  color: Colors.white),
            ),
          ),
        ),
      );
    },
  );
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
