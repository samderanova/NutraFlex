import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final title;
  MyHomePage({this.title});

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
                    MaterialPageRoute(builder: (context) => Login()),
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

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: Text('Enter your information'),
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Weight (lbs)',
                    ),
                    keyboardType: TextInputType.number,
                    autocorrect: true,
                    autofocus: true,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Height (in)'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'[\D]')),
                    ],
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
                              onPressed: () {},
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
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
        ),
      ),
    );
  }
}
