import 'package:flutter/material.dart';
import 'package:places/ui/screen/root_app.dart';

import 'ui/res/themes.dart';

bool isDarkTheme = false;

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RootApp(),
      title: "places",
      theme: isDarkTheme ? darkTheme : lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
