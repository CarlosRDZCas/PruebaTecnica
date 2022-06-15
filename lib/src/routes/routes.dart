import 'package:flutter/material.dart';

import '../pages/pages.dart';

getRoutes() {
  return (RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => LoginPage(), settings: settings);
      case '/home':
        return MaterialPageRoute(builder: (_) => Pokedex(), settings: settings);
      case '/pokemondetails':
        return MaterialPageRoute(
            builder: (_) => PokemonDetailsPage(), settings: settings);
    }
  };
}
