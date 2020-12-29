import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: MySecondWidget(),
      title: "MyFirstTitle",
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MySecondWidget(),
    );
  }
}

class MySecondWidget extends StatefulWidget {



  @override
  _MySecondWidgetState createState() => _MySecondWidgetState();
}



class _MySecondWidgetState extends State<MySecondWidget> {
  int count = 0;


  @override
  Widget build(BuildContext context) {
    Type ref(){
      return context.runtimeType;
    }


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
  int count = 0;

  @override
  Widget build(BuildContext context) {

    Type ref(){
      return context.runtimeType;
    }
    //print(ref());

    //count++;
    //print("Метод build в MyFirstWidget был вызван $count раз");
    return Container(
      child: Center(
        child: Text(ref().toString()),
      ),
    );
  }
}







class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), //
    );
  }
}
