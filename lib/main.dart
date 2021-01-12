import 'package:flutter/material.dart';
import 'package:places/ui/screen/sight_list_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SightListScreen(),
      title: "MyFirstTitle",
      theme: ThemeData(fontFamily: 'Roboto'),
    );
  }
}

class MySecondWidget extends StatefulWidget {
  //Это второй виджет Stateful
  @override
  _MySecondWidgetState createState() => _MySecondWidgetState();
}
class _MySecondWidgetState extends State<MySecondWidget> {
  int count = 0;
  Type ref() => context.runtimeType;
  @override
  Widget build(BuildContext context) {
    //count++;
    //print("Метод build в MySecondWidget был вызван $count раз");
    return Container(
      child: Center(
        child: Text(ref().toString()),
      ),
    );
  }
}

class MyFirstWidget extends StatelessWidget {
  //Это первый виджет Stateless
  int count = 0;
  Type ref() => this.runtimeType;
  @override
  Widget build(BuildContext context) {

    //print("Метод build в MyFirstWidget был вызван $count раз");
    return Container(
      child: Center(
        child: Text(ref().toString()),
      ),
    );
  }
}
