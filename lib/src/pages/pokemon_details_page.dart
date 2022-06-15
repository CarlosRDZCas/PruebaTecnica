import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/src/widgets/widgets.dart';

import '../models/pokemon_model.dart';

class PokemonDetailsPage extends StatelessWidget {
  const PokemonDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Banner(pokemon: pokemon),
            const Details(),
            const Header(),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 10,
      child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          )),
    );
  }
}

class Details extends StatelessWidget {
  const Details({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: FadeInUpBig(
          duration: const Duration(milliseconds: 500),
          child: Transform.translate(
            offset: const Offset(0, 270),
            child: Container(
                alignment: Alignment.topCenter,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: const [
                    TabBar(
                        isScrollable: true,
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Pokemon',
                          letterSpacing: 1.8,
                        ),
                        padding: EdgeInsets.all(8),
                        indicatorColor: Colors.black,
                        labelColor: Colors.black,
                        tabs: [
                          Tab(
                            text: 'Acerca de',
                          ),
                          Tab(
                            text: 'Estadisticas',
                          ),
                          Tab(
                            text: 'Movimientos',
                          ),
                        ]),
                    Expanded(
                      child: TabBarView(children: [
                        AcercaDe(),
                        Estadisticas(),
                        Movimientos(),
                      ]),
                    ),
                  ],
                )),
          ),
        ));
  }
}

class Banner extends StatelessWidget {
  const Banner({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 300,
        child: Hero(
            tag: 'pokemon-${pokemon.id}',
            child: FadeOutUp(
                child: CardPokemon(pokemon: pokemon, pantalla: 'details'))));
  }
}

class AcercaDe extends StatelessWidget {
  const AcercaDe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Acerca De'),
    );
  }
}

class Estadisticas extends StatelessWidget {
  const Estadisticas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Estadisticas'),
    );
  }
}

class Movimientos extends StatelessWidget {
  const Movimientos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Movimientos'),
    );
  }
}
