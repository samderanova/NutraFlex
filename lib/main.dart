import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './widgets/home.dart';
import './widgets/welcome.dart';

/*
NOTE!!!!

Just a reminder, if you want to convert a widget from stateless to stateful,
you can click on the word "StatelessWidget" or 
"StatefulWidget", press ctrl + '.', and click "Convert to ____".

*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<SharedPreferences> data = SharedPreferences.getInstance();
  Future<String> name;
  String stringName;
  @override
  void initState() {
    super.initState();
    name = data.then((SharedPreferences prefs) {
      getName();
      return (prefs.getString('name') ?? '');
    });
  }

  Future getName() async {
    var stringVersionOfName = await name;
    setState(() {
      stringName = stringVersionOfName;
    });
  }

  @override
  Widget build(BuildContext context) {
    getName();
    Widget widgetToLoad;
    if (stringName != '') {
      widgetToLoad = SafeArea(
        child: Home(stringName, data),
      );
    } else {
      widgetToLoad = SafeArea(
        child: Welcome(
          data: data,
        ),
      );
    }

    return MaterialApp(
      routes: {
        '/welcome': (context) => Welcome(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: widgetToLoad,
    );
  }
}
