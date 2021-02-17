import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './registerForm.dart';
import './login.dart';

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
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  child: Center(
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  padding: EdgeInsets.only(top: 20),
                ),
                Center(
                  child: FlatButton(
                    child: Text(
                      'Already have an account? Click here!',
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SafeArea(
                            child: Login(widget.data),
                          ),
                        ),
                      );
                    },
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
          ],
        ),
      ),
    );
  }
}
