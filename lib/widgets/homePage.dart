import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quote.dart';
import './welcome.dart';
import './barchart.dart';

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

  void _logOut() {
    setState(() {
      widget.data.then((SharedPreferences prefs) {
        prefs.clear();
      });
    });
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SafeArea(child: Welcome(data: widget.data))));
    // Navigator.pushNamedAndRemoveUntil(context, '/welcome', (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
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
                  )
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
                          Container(
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
                            margin: EdgeInsets.all(15),
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
              Container(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: BarChart.withSampleData(),
                ),
                margin: EdgeInsets.all(20),
              ),
              Column(
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
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
