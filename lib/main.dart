import 'package:flutter/material.dart';
import 'package:places/ui/screen/root_app.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RootApp(),
      title: "MyFirstTitle",
      theme: ThemeData(fontFamily: 'Roboto'),
      debugShowCheckedModeBanner: false,
    );
  }
}
