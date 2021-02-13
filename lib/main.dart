import 'dart:async';
import 'package:NutraFlex/widgets/workouts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './widgets/form.dart';
import './widgets/workouts.dart';
import './widgets/home.dart';

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
      print(prefs.getString('name'));
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (name.toString() != '') ? Home(name: stringName,) : Welcome(),
    );
  }
}

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: Text(
                'Welcome!',
                style: TextStyle(fontSize: 40),
              ),
            ),
            Center(
              child: FlatButton(
                child: Text('Click here to start >'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterOrLogin()),
                  );
                },
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
        ),
      ),
    );
  }
}

class RegisterOrLogin extends StatefulWidget {
  @override
  _RegisterOrLoginState createState() => _RegisterOrLoginState();
}

class _RegisterOrLoginState extends State<RegisterOrLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: Text(
                'Register',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Center(
              child: Text(
                'Already have an account? Click here',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),

            // Input form for user
            CustomForm(),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  final String name;
  Home({this.name});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;

  var _widgets = [
    /* 
    We'll eventually replace these widges with
    Workouts()
    Home()    
    Nutrition()
    respectively.
    */
    Workouts(),
    '',
    Text('Nutrition'),
  ];

  void _tap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _widgets[1] = HomePage(widget.name);
    return Scaffold(
      body: Center(
        child: _widgets[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workouts',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dinner_dining),
            label: 'Nutrition',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _tap,
      ),
    );
  }
}
