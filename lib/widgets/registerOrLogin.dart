import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './form.dart';

class RegisterOrLogin extends StatefulWidget {
  final Future<SharedPreferences> data;
  RegisterOrLogin({this.data});

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
              child: FlatButton(
                child: Text('Already have an account? Click here!',
                    style: TextStyle(color: Colors.green)),
                onPressed: () {},
              ),
            ),

            // Input form for user
            Container(
              child: CustomForm(
                data: widget.data,
              ),
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
        ),
      ),
    );
  }
}


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
