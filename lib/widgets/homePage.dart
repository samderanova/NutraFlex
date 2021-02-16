import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quote.dart';

class HomePage extends StatefulWidget {
  final String name;
  final Future<SharedPreferences> data;
  HomePage({this.name, this.data});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future futureQuote;
  double _currentSliderValue = 1;

  @override
  // Initialize the state by fetching a quote from the API
  void initState() {
    super.initState();
    futureQuote = fetchQuote();
  }

  _logOut() async {
    setState(() {
      widget.data.then((SharedPreferences prefs) {
        prefs.clear();
      });
    });
    Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Hello, ${widget.name}!',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: RaisedButton(
                  child: Text('Log Out'),
                  onPressed: _logOut,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),

          // The Future object we got from fetching a quote is "built" here.
          FutureBuilder(
              future: futureQuote,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(
                        "Here's an inspirational quote just for you!",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                snapshot.data.quoteText,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Text(
                              '- ${snapshot.data.author}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: EdgeInsets.all(15),
                    child: Center(
                      child: Text(
                        snapshot.error.toString().substring(11),
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                }
                return CircularProgressIndicator();
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Text('Control the tension of your bow with the slider'),
                Slider(
                  value: _currentSliderValue,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: _currentSliderValue.toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
