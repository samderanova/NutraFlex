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

  bool _checkCredentials(String email, String password) {
    var correctCredentials = false;
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                if (doc["email"] == email && doc["password"] == password) {
                  correctCredentials = true;
                }
              })
            });
    if (correctCredentials) {
      return true;
    }
    return false;
  }

  _setName(String email) async {
    setState(() {
      widget.data.then((SharedPreferences prefs) {
        prefs.setString('name', name);
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
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          if (!_checkCredentials(
                            emailController.text,
                            passwordController.text,
                          )) {
                            return Text('Incorrect email/password');
                          } else {
                            _setName(emailController.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HomePage(name: name, data: widget.data),
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
