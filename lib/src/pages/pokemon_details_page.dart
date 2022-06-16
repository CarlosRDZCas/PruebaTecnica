import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:pokedex/src/widgets/widgets.dart';

import '../bloc/pokemondetails/pokemondetails_bloc.dart';
import '../models/models.dart';
import '../services/pokemon_details_service.dart';

class PokemonDetailsPage extends StatelessWidget {
  const PokemonDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;

    return BlocProvider(
      create: (context) => PokemondetailsBloc(PokemonDetailsService()),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<PokemondetailsBloc, PokemondetailsState>(
            builder: (context, state) {
              if (state is PokemondetailsInitial) {
                context
                    .read<PokemondetailsBloc>()
                    .add(LoadingPokemonDetailsEvent(pokemon.id));
              }

              if (state is PokemondetailsLoadedState) {
                return Stack(
                  children: [
                    Banner(pokemon: pokemon),
                    Details(
                      pokemon: pokemon,
                      pokemonDetails: state.pokemonDetails!,
                    ),
                    const Header(),
                  ],
                );
              }

              if (state is PokemondetailsErrorState) {
                return const Center(
                  child: Text('Error'),
                );
              }
              return Center(
                child: Container(),
              );
            },
          ),
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
  PokemonDetails pokemonDetails;
  Pokemon pokemon;
  Details({Key? key, required this.pokemon, required this.pokemonDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: FadeInUp(
          duration: const Duration(milliseconds: 400),
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
                  children: [
                    const TabBar(
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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.0, top: 25),
                        child: TabBarView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: AcercaDe(
                                  pokemon: pokemon,
                                  pokemonDetails: pokemonDetails,
                                ),
                              ),
                              Estadisticas(pokemon: pokemon),
                              const Movimientos(),
                            ]),
                      ),
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
          child: FadeInDown(
              delay: Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 250),
              child: CardPokemon(pokemon: pokemon, pantalla: 'details')),
        ));
  }
}

class AcercaDe extends StatelessWidget {
  final Pokemon pokemon;
  final PokemonDetails pokemonDetails;
  const AcercaDe(
      {Key? key, required this.pokemonDetails, required this.pokemon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Especie: ',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Pokemon',
                  letterSpacing: 1.8,
                ),
              ),
              Text(
                pokemonDetails.genera[5].genus,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Pokemon',
                  letterSpacing: 1.8,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              const Text(
                'Altura: ',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Pokemon',
                  letterSpacing: 1.8,
                ),
              ),
              Text(
                (pokemon.height * 10 / 100).toString() + ' m',
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Pokemon',
                  letterSpacing: 1.8,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              const Text(
                'Peso: ',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Pokemon',
                  letterSpacing: 1.8,
                ),
              ),
              Text(
                (pokemon.weight * 10 / 100).toString() + ' kg',
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Pokemon',
                  letterSpacing: 1.8,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              const Text(
                'Habilidades: ',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Pokemon',
                  letterSpacing: 1.8,
                ),
              ),
              Expanded(
                child: Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width - 15,
                  child: ListView.builder(
                    itemCount: pokemon.abilities.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: false,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: Center(
                          child: Text(
                            pokemon.abilities[index].ability.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Pokemon',
                              letterSpacing: 1.8,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              const Text(
                'Habitat: ',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Pokemon',
                  letterSpacing: 1.8,
                ),
              ),
              Text(
                pokemonDetails.habitat.name,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Pokemon',
                  letterSpacing: 1.8,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              const Text(
                'Crecimiento: ',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Pokemon',
                  letterSpacing: 1.8,
                ),
              ),
              Text(
                pokemonDetails.growthRate.name,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Pokemon',
                  letterSpacing: 1.8,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              const Text(
                'Forma: ',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Pokemon',
                  letterSpacing: 1.8,
                ),
              ),
              Text(
                pokemonDetails.shape.name,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Pokemon',
                  letterSpacing: 1.8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Estadisticas extends StatelessWidget {
  final Pokemon? pokemon;
  const Estadisticas({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<StatsData> listData = [];
    for (var item in pokemon!.stats) {
      StatsData statData = StatsData(
        item.stat.name.replaceAll('-', ' '),
        item.baseStat,
        item.baseStat > 50
            ? item.baseStat < 76
                ? Colors.orange
                : Colors.green
            : Colors.red,
      );
      listData.add(statData);
    }
    return Transform.translate(
      offset: const Offset(0, -170),
      child: FadeIn(
        duration: Duration(milliseconds: 600),
        child: Container(
          child: SfCircularChart(
            series: <CircularSeries>[
              // Renders radial bar chart
              RadialBarSeries<StatsData, String>(
                  animationDuration: 800,
                  maximumValue: 100,
                  strokeWidth: 0.9,
                  gap: '3%',
                  radius: '95%',
                  useSeriesColor: true,
                  innerRadius: '35%',
                  trackOpacity: 0.2,
                  cornerStyle: CornerStyle.bothCurve,
                  dataLabelMapper: (StatsData data, _) =>
                      data.name + ': ' + data.value.toString(),
                  dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      textStyle: TextStyle(
                          fontSize: 9,
                          fontFamily: 'Pokemon',
                          letterSpacing: 0)),
                  dataSource: listData,
                  pointColorMapper: (StatsData data, _) => data.colors,
                  xValueMapper: (StatsData data, _) => data.name,
                  yValueMapper: (StatsData data, _) => data.value)
            ],
          ),
        ),
      ),
    );
  }
}

class Movimientos extends StatelessWidget {
  const Movimientos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Movimientos'),
    );
  }
}
