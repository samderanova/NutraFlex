import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class CustomForm extends StatefulWidget {
  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  String name = '';

  _setName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = nameController.text;
      prefs.setString('name', name);
      prefs.setBool('registered', true);
    });
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
                          _setName(nameController.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
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
