import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './home.dart';

class CustomForm extends StatefulWidget {
  final Future<SharedPreferences> data;
  CustomForm({this.data});

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  String name = '';
  String dietChoice = 'Vegan';

  _setName() async {
    setState(() {
      name = nameController.text;
      widget.data.then((SharedPreferences prefs) {
        prefs.setString('name', name);
      });
    });
  }

  Future addUser(double height, double weight, String email, String password) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .add({
          'name': name,
          'height': height,
          'weight': weight,
          'email': email,
          'password': password,
        })
        .then((value) => print('User added!'))
        .catchError((error) => print('Error: $error'));
  }

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final createPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  // dietController not included because a controller is not needed

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a name!';
              }
              return null;
            },
          ),
          TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter an email!';
                } else if (!value.contains('@')) {
                  return 'Please enter a valid email!';
                } else {
                  return null;
                }
              }),
          TextFormField(
              controller: createPasswordController,
              decoration: InputDecoration(labelText: 'Create a password'),
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a password!';
                }
                return null;
              }),
          TextFormField(
              controller: confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm your password'),
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a password!';
                } else if (confirmPasswordController.text !=
                    createPasswordController.text) {
                  return 'The passwords must match!';
                }
                return null;
              }),
          TextFormField(
            controller: weightController,
            decoration: InputDecoration(labelText: 'Weight (lbs)'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a weight!';
              }
              try {
                double.parse(value);
              } catch (e) {
                return 'Please enter a number!';
              }
              return null;
            },
          ),
          TextFormField(
            controller: heightController,
            decoration: InputDecoration(labelText: 'Height (in)'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a height!';
              }
              try {
                double.parse(value);
              } catch (e) {
                return 'Please enter a number!';
              }
              return null;
            },
          ),
          Container(
            child: Text(
              'Please select a diet: ',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            padding: EdgeInsets.only(top: 25, bottom: 15),
          ),
          Column(
            children: [
              RadioListTile(
                title: Text('Vegan', style: TextStyle(fontSize: 19)),
                value: 'Vegan',
                groupValue: dietChoice,
                onChanged: (String value) {
                  setState(() {
                    dietChoice = value;
                  });
                },
              ),
              RadioListTile(
                title: Text('Vegetarian', style: TextStyle(fontSize: 19)),
                value: 'Vegetarian',
                groupValue: dietChoice,
                onChanged: (String value) {
                  setState(() {
                    dietChoice = value;
                  });
                },
              )
            ],
          ),
          Row(
            children: [
              Container(
                child: ButtonBar(
                  children: [
                    FlatButton(
                      child: Text(
                        'Clear',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {},
                    ),
                    RaisedButton(
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _setName();
                          addUser(
                              double.parse(weightController.text),
                              double.parse(heightController.text),
                              emailController.text,
                              confirmPasswordController.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SafeArea(
                                child: Home(name, widget.data),
                              ),
                            ),
                          );
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
