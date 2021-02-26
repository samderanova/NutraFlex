import 'package:flutter/material.dart';
import './workoutPageWidgets.dart';

class Workouts extends StatefulWidget {
  @override
  _WorkoutsState createState() => _WorkoutsState();
}

class _WorkoutsState extends State<Workouts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            child: Text(
              'Here are some workouts just for you!',
              style: TextStyle(fontSize: 30),
            ),
            margin: EdgeInsets.all(15),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  child: Column(
                    children: [
                      Text(
                        'Arms:',
                        style: DefaultTextStyle.of(context)
                            .style
                            .apply(fontSizeFactor: 2.5),
                      ),
                      WorkoutName('1. Bicep Curl'),
                      WorkoutName('2. Upright Row'),
                      WorkoutName('3. One Arm Row'),
                      WorkoutName('4. Decline Press'),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  margin: EdgeInsets.all(15)),
              Container(
                  child: Column(
                    children: [
                      Text('Chest:',
                          style: DefaultTextStyle.of(context)
                              .style
                              .apply(fontSizeFactor: 2.5)),
                      WorkoutName('1. Chest Fly'),
                      WorkoutName('2. Chest Press'),
                      WorkoutName('3. Band Flys'),
                      WorkoutName('4. Incline Press'),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  margin: EdgeInsets.all(15)),
              Container(
                  child: Column(
                    children: [
                      Text('Shoulders:',
                          style: DefaultTextStyle.of(context)
                              .style
                              .apply(fontSizeFactor: 2.5)),
                      WorkoutName('1. Shrugs'),
                      WorkoutName('2. Shoulder Press'),
                      WorkoutName('3. Clean and Press'),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  margin: EdgeInsets.all(15)),
              Container(
                  child: Column(
                    children: [
                      Text('Back:',
                          style: DefaultTextStyle.of(context)
                              .style
                              .apply(fontSizeFactor: 2.5)),
                      WorkoutName('1. Seated Row'),
                      WorkoutName('2. Bent Over Row'),
                      WorkoutName('3. Lat Pull Downs'),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  margin: EdgeInsets.all(15))
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
