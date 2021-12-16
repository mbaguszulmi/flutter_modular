import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/routes/routes.dart';
import 'package:flutter_modular/ui/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  await SharedPref.init();
  MainRouter.initRoutes();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Modular',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) => generateRoutes(settings, context),
      initialRoute: MyHomePage.path,
    );
  }
}

