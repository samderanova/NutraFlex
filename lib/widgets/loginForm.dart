import 'package:NutraFlex/widgets/homePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginForm extends StatefulWidget {
  final Future<SharedPreferences> data;
  LoginForm(this.data);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String name = '';

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future _checkCredentials(String email, String password) async {
    var successful = await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) => querySnapshot);
    var correctCredential = [];
    successful.docs.forEach((doc) {
      if (email == doc["email"] && password == doc["password"]) {
        correctCredential.add(doc["name"]);
      }
    });
    return correctCredential;
  }

  _setName(String userName) async {
    setState(() {
      widget.data.then((SharedPreferences prefs) {
        prefs.setString('name', userName);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please provide an email!';
              }
              return null;
            },
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please provide a password!';
              }
              return null;
            },
          ),
          Row(
            children: [
              Container(
                child: ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      child: Text(
                        'Clear',
                        style: TextStyle(color: Colors.green, fontSize: 20),
                      ),
                      onPressed: () {
                        emailController.clear();
                        passwordController.clear();
                      },
                    ),
                    RaisedButton(
                      child: Text('Submit', style: TextStyle(fontSize: 20)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          var response = await _checkCredentials(
                              emailController.text, passwordController.text);
                          if (response.isEmpty) {
                            return Text('Incorrect email/password');
                          } else {
                            _setName(response[0]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(
                                    name: response[0], data: widget.data),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
                margin: EdgeInsets.all(15),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )
        ],
      ),
    );
  }
}
