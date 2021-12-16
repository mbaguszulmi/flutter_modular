import 'package:commons/common_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_a/module_a.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  static const path = '/';
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();

    authBloc.stream.listen((state) {
      debugPrint("Updating... $state");
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(authBloc.state.isLoggedIn
                ? "${authBloc.state.name}"
                : "Not Logged In"),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                if (authBloc.state.isLoggedIn) {
                  authBloc.add(LogoutAuthEvent());
                  debugPrint("Logout");
                  return;
                }

                debugPrint("Login");

                authBloc.add(const LoginAuthEvent("Muhammad Bagus Zulmi"));
              },
              child: Text(authBloc.state.isLoggedIn ? "Logout" : "Login"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed(AScreen.path);
              },
              child: const Text("Module A"),
            )
          ],
        ),
      ),
    );
  }
}
