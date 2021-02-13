import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String name;
  HomePage(this.name);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Welcome ${widget.name}'),
    );
  }
}
