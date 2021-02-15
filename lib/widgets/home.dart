import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './workouts.dart';
import './homePage.dart';

class Home extends StatefulWidget {
  final String name;
  final Future<SharedPreferences> data;
  Home(this.name, this.data);

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
    _widgets[1] = HomePage(
      name: widget.name,
      data: widget.data,
    );
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
