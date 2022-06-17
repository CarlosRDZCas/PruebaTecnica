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
          return Container(
            padding: const EdgeInsets.only(left: 10, top: 15),
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: const Text(
                    'Tus equipos',
                    style: TextStyle(
                      fontFamily: 'Pokemon',
                      fontSize: 20,
                      letterSpacing: 1.8,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Text(
                            snapshot.data![index].nombreEquipo,
                            style: const TextStyle(
                              fontFamily: 'Pokemon',
                              fontSize: 15,
                              letterSpacing: 1.8,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 15),
                                height: 78,
                                width: 291,
                                child: ListView.builder(
                                  itemCount:
                                      snapshot.data![index].pokemons.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index2) {
                                    print(
                                        snapshot.data![index].pokemons[index2]);
                                    for (var element in pokemons!) {
                                      if (element.name ==
                                          snapshot
                                              .data![index].pokemons[index2]) {
                                        return Container(
                                          child: Image.network(
                                            element.sprites.other!
                                                .officialArtwork.frontDefault,
                                            fit: BoxFit.fill,
                                          ),
                                        );
                                      }
                                    }
                                    return Container();
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
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
