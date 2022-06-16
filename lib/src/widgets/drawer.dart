import 'package:flutter/material.dart';
import 'package:pokedex/src/settings/preferences.dart';

import '../models/models.dart';
import '../provider/db_provider.dart';

class CustomDrawer extends StatelessWidget {
  final List<Pokemon>? pokemons;
  const CustomDrawer({Key? key, this.pokemons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TeamModel> teamModelList = [];
    return SafeArea(
      child: Drawer(
          child: FutureBuilder<List<TeamModel>>(
        initialData: teamModelList,
        future: DBProvider.db.selectTeams(Preferences.getUser()),
        builder:
            (BuildContext context, AsyncSnapshot<List<TeamModel>> snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Expanded(
                child: Column(
                  children: [
                    Expanded(child: Text(snapshot.data![index].nombreEquipo)),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Expanded(
                              child: ListView.builder(
                                itemCount:
                                    snapshot.data![index].pokemons.length,
                                shrinkWrap: true,
                                itemBuilder:
                                    (BuildContext context, int index2) {
                                  print(snapshot.data![index].pokemons[index2]);
                                  return Expanded(
                                    child: Text(
                                        snapshot.data![index].pokemons[index2]),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
          // return Column(
          //   children: [
          //     Container(
          //       height: 20,
          //       width: double.infinity,
          //       child: Text(snapshot.data![]),
          //     ),
          //     Expanded(
          //       child: Row(
          //         children: [
          //           Expanded(
          //             child: ListView.builder(
          //               itemCount: snapshot.data!.pokemons.length,
          //               scrollDirection: Axis.horizontal,
          //               shrinkWrap: true,
          //               itemBuilder: (BuildContext context, int index) {
          //                 return Column(
          //                   children: [
          //                     Container(
          //                       child: Text(snapshot.data!.pokemons[index]),
          //                     ),
          //                   ],
          //                 );
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // );
        },
      )),
    );
  }
}
