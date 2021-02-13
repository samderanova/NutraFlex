import 'package:flutter/material.dart';

class Workouts extends StatefulWidget {
  @override
  _WorkoutsState createState() => _WorkoutsState();
}

class _WorkoutsState extends State<Workouts> {
  double _currentSliderValue = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Control the tension of your bow with the slider'),
        Slider(
          value: _currentSliderValue,
          min: 1,
          max: 5,
          divisions: 4,
          label: _currentSliderValue.toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
