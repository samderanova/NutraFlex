import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './loginForm.dart';
import './registerOrLogin.dart';

class Login extends StatefulWidget {
  final Future<SharedPreferences> data;
  Login(this.data);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: Text(
                'Log In',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Center(
              child: FlatButton(
                child: Text(
                  "Don't have an account? Click here!",
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SafeArea(
                        child: RegisterOrLogin(
                          data: widget.data,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Input form for user
            Container(
              child: LoginForm(widget.data),
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
