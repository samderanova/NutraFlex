import 'package:flutter/material.dart';

class WorkoutName extends StatelessWidget {
  final String name;
  WorkoutName(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        name,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      margin: EdgeInsets.all(5)
    );
  }
}
