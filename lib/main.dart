import 'package:flutter/material.dart';
import './widgets/form.dart';


/*
NOTE!!!!

Just a reminder, if you want to convert a widget from stateless to stateful,
you can put your cursor directly over the word "StatelessWidget" or 
"StatefulWidget", press ctrl + '.', and click "Convert to ____".

*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Welcome(title: 'Flutter Demo Home Page'),
    );
  }
}

class Welcome extends StatelessWidget {
  final title;
  Welcome({this.title});

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
                  color: Colors.blue,
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
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;

  static const _widgets = [
    /* 
    We'll eventually replace these widges with
    Workouts()
    Home()    
    Nutrition()
    respectively.
    */
    Text('Workouts'),
    Text('Home Page'),
    Text('Nutrition'),
  ];

  void _tap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgets[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workouts',
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
