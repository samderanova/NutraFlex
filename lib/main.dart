import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './widgets/home.dart';
import './widgets/welcome.dart';
import 'package:firebase_core/firebase_core.dart';

/*
NOTE!!!!

Just a reminder, if you want to convert a widget from stateless to stateful,
you can click on the word "StatelessWidget" or 
"StatefulWidget", press ctrl + '.', and click "Convert to ____".

*/

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

  bool _initialized = false;
  bool _error = false;

  @override
  void initState() {
    initializeFlutterFire();
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

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized) {
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
    } else if (_error) {
      return MaterialApp(home: Scaffold(body: Text('Uh oh! Something went wrong...')));
    } else {
      return MaterialApp(home: Scaffold(body: Text('Loading...')));
    }
  }
}
