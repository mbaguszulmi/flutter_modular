import 'package:flutter/material.dart';

class Page404 extends StatelessWidget {
  static const path = '/404';
  const Page404({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("404 Not Found!"),
      ),
    );
  }
}
