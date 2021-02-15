import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './registerOrLogin.dart';

class Welcome extends StatelessWidget {
  final Future<SharedPreferences> data;
  Welcome({this.data});

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
                    MaterialPageRoute(
                      builder: (context) => SafeArea(
                        child: RegisterOrLogin(
                          data: data,
                        ),
                      ),
                    ),
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