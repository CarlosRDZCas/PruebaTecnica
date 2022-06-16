import 'package:flutter/material.dart';
import 'package:pokedex/src/settings/preferences.dart';

import '../models/models.dart';
import '../provider/db_provider.dart';

class CustomDrawer extends StatelessWidget {
  final List<Pokemon>? pokemons;
  const CustomDrawer({Key? key, this.pokemons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TeamModel teammodel = TeamModel('', '', []);
    return SafeArea(
      child: Drawer(
          child: FutureBuilder<TeamModel>(
        initialData: teammodel,
        future: DBProvider.db.selectTeams(Preferences.getUser()),
        builder: (BuildContext context, AsyncSnapshot<TeamModel> snapshot) {
          return Column(
            children: [
              Container(
                height: 20,
                width: double.infinity,
                child: Text(snapshot.data!.nombreEquipo),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.pokemons.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Text(snapshot.data!.pokemons[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      )),
    );
  }
}
