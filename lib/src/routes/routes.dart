import 'package:flutter/material.dart';

import '../pages/pages.dart';

getRoutes() {
  return (RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const LoginPage(), settings: settings);
      case '/home':
        return MaterialPageRoute(
            builder: (_) => const Pokedex(), settings: settings);
      case '/pokemondetails':
        return MaterialPageRoute(
            builder: (_) => const PokemonDetailsPage(), settings: settings);
      case '/selectteam':
        return MaterialPageRoute(
            builder: (_) => const SelectTeam(), settings: settings);
    }
  };
}
