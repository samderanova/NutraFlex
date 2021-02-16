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

  _setName() async {
    setState(() {
      name = nameController.text;
      widget.data.then((SharedPreferences prefs) {
        prefs.setString('name', name);
      });
    });
  }

  Future addUser(double height, double weight) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .add({
          'name': name,
          'height': height,
          'weight': weight,
        })
        .then((value) => print('User added!'))
        .catchError((error) => print('Error: $error'));
  }

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

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
            controller: weightController,
            decoration: InputDecoration(labelText: 'Weight (lbs)'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a weight!';
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
              return null;
            },
          ),
          // Implement unit converter
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
                          );
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
