import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/root_app.dart';

bool isDarkTheme = false;

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      home: RootApp(),
      title: "MyFirstTitle",
      theme: isDarkTheme ? darkTheme : lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
