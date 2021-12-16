import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/ui/home_screen.dart';
import 'package:flutter_modular/ui/page_404.dart';
import 'package:module_a/module_a.dart';

Route<dynamic> generateRoutes(RouteSettings settings, BuildContext context) {
  debugPrint("Generating Routes");

  final routes = MainRouter.routes;

  for (var path in routes.keys) {
    if (path == settings.name) {
      return MaterialPageRoute(builder: (context) => routes[path]!(settings));
    }
  }

  return MaterialPageRoute(
      builder: (context) => routes[Page404.path]!(settings));
}

class MainRouter {
  static final Map<String, Widget Function(RouteSettings)> _routes = {
    MyHomePage.path: (settings) => navigateWithBloc(
          child: const MyHomePage(title: "Flutter Modular"),
        ),
    Page404.path: (settings) => navigateWithBloc(
          child: const Page404(),
        ),
  };

  static Map<String, Widget Function(RouteSettings)> get routes => _routes;

  static void initRoutes() {
    // register routes here
    _appendRoutes(generateARoute());
  }

  static Widget navigateWithBloc({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _GlobalBloc.authBloc,
        ),
      ],
      child: child,
    );
  }

  static void _appendRoutes(
      Map<String, Widget Function(RouteSettings)> otherRoutes) {
    var duplicateRoutesSet =
        otherRoutes.keys.toSet().intersection(_routes.keys.toSet());
    if (duplicateRoutesSet.isNotEmpty) {
      throw Exception(
          "Routes must be unique! There's duplicate routes $duplicateRoutesSet");
    }

    for (var path in otherRoutes.keys) {
      _routes[path] =
          (settings) => navigateWithBloc(child: otherRoutes[path]!(settings));
    }
  }
}

class _GlobalBloc {
  static final authBloc = AuthBloc()..add(InitialAuthEvent());
}
