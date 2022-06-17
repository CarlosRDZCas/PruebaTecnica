import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

import '../models/models.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();

    return _database;
  }

  Future<Database?> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "pokedex.db");

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
              CREATE TABLE "PokemonTeam" (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              Usuario TEXT,
              NombreEquipo TEXT,
              UNIQUE (Usuario,NombreEquipo));
            ''');

        await db.execute('''  CREATE TABLE "PokemonsTeam" (
              "ID"	INTEGER PRIMARY KEY AUTOINCREMENT,
              "PokemonTeamID"	INTEGER,
              "Pokemon"	TEXT,
              FOREIGN KEY("PokemonTeamID") REFERENCES PokemonTeam(ID));''');
      },
    );
  }

  Future<bool> insertTeam(TeamModel team) async {
    try {
      final db = await database;
      await db!.rawInsert('''
      INSERT INTO PokemonTeam (Usuario, NombreEquipo) VALUES("${team.usuario}","${team.nombreEquipo}");''');

      for (var element in team.pokemons) {
        await db.rawInsert('''
          INSERT Into PokemonsTeam (PokemonTeamID,Pokemon) VALUES((select seq from sqlite_sequence where name = "PokemonTeam"),"$element")''');
      }
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<List<TeamModel>> selectTeams(String user) async {
    try {
      final db = await database;
      final res = await db!.rawQuery('''
      SELECT * FROM PokemonTeam WHERE Usuario = "$user";''');

      List<TeamModel> listTeam = [];
      for (var element in res) {
        TeamModel team = TeamModel('', '', []);
        team.usuario = element['Usuario'].toString();
        team.nombreEquipo = element['NombreEquipo'].toString();
        final res2 = await db.rawQuery('''
          SELECT * FROM PokemonsTeam WHERE PokemonTeamID = ${element['id']};''');

        for (var element2 in res2) {
          team.pokemons.add(element2['Pokemon'].toString());
        }
        listTeam.add(team);
      }
      return listTeam;
    } catch (ex) {
      return [];
    }
  }
}
