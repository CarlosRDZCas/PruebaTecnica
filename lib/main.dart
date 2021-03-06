import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/src/services/services.dart';

import 'src/bloc/login/login_bloc.dart';
import 'src/bloc/pokemon/pokemon_bloc.dart';
import 'src/bloc/pokemondetails/pokemondetails_bloc.dart';
import 'src/bloc/selectteam/selectteam_bloc.dart';
import 'src/routes/routes.dart';
import 'src/settings/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(),
          ),
          BlocProvider(
            create: (context) => PokemonBloc(PokemonServices()),
          ),
          BlocProvider(
            create: (context) => SelectteamBloc(),
          ),
          BlocProvider(
            create: (context) => PokemondetailsBloc(PokemonDetailsService()),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Pokedex',
            initialRoute: Preferences.getUser() == '' ? '/' : '/home',
            onGenerateRoute: getRoutes()));
  }
}
