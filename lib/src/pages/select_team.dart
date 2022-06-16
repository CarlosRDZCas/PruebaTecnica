import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/src/provider/db_provider.dart';
import 'package:pokedex/src/widgets/pokemon_card.dart';

import '../bloc/selectteam/selectteam_bloc.dart';

import '../components/components.dart';
import '../models/models.dart';
import '../settings/preferences.dart';

class SelectTeam extends StatelessWidget {
  const SelectTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemons =
        ModalRoute.of(context)!.settings.arguments as List<Pokemon>;
    return Scaffold(
      appBar: CustomAppbar(),
      body: GridBuilderTeam(pokemons: pokemons),
    );
  }
}

class GridBuilderTeam extends StatelessWidget {
  const GridBuilderTeam({
    Key? key,
    required this.pokemons,
  }) : super(key: key);

  final List<Pokemon> pokemons;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const BouncingScrollPhysics(),
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
        });
  }
}

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppbar({
    Key? key,
  }) : super(key: key);

  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TeamModel team = TeamModel('', '', []);
    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.0),
      elevation: 0,
      centerTitle: true,
      foregroundColor: Colors.black,
      actions: [
        BlocBuilder<SelectteamBloc, SelectteamState>(
          builder: (context, state) {
            if (state is SelectedState) {
              team.usuario = Preferences.getUser();
              return IconButton(
                icon: const Icon(Icons.check),
                onPressed: () async {
                  if (state.selectedPokemonsLength < 6) {
                    ShowSnackBar(
                        context, 'Debe seleccionar 6 Pokemons', 4, Colors.red);
                  } else {
                    String? text = await openDialog(context);
                    team.nombreEquipo = text ?? '';
                    if (team.nombreEquipo.isEmpty) {
                      ShowSnackBar(
                          context,
                          'Para guardar su equipo debe ingresar un nombre',
                          4,
                          Colors.red);
                    } else {
                      if (await DBProvider.db.insertTeam(team)) {
                        ShowSnackBar(context, 'Equipo agregado con exito!', 5,
                            Colors.green);
                      } else {
                        ShowSnackBar(context, 'Ya existe un equipo con ese', 5,
                            Colors.red);
                      }
                      //Navigator.pop(context);
                    }
                  }
                },
              );
            }
            return const SizedBox();
          },
        ),
      ],
      title: BlocBuilder<SelectteamBloc, SelectteamState>(
        builder: (context, state) {
          if (state is SelectedState) {
            team.pokemons = state.selectedPokemons ?? [];
            return FadeInDown(
              child: Text(
                  '${state.selectedPokemonsLength} Pokemon(s) seleccionados',
                  style: const TextStyle(
                      fontFamily: 'Pokemon', letterSpacing: 1.8, fontSize: 15)),
            );
          }
          return const Text('Selecciona tu equipo',
              style: TextStyle(fontFamily: 'Pokemon'));
        },
      ),
    );
  }

  Future<String?> openDialog(BuildContext context) => showDialog<String?>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Ingrese el nombre del equipo"),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Nombre del equipo",
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    submit(context);
                  },
                  child: const Text('Agregar'))
            ],
          ));
  void submit(context) {
    Navigator.of(context).pop(controller.text);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
