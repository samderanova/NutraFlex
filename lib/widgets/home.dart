import 'package:flutter/material.dart';
import '../models/quote.dart';

class HomePage extends StatefulWidget {
  final String name;
  HomePage(this.name);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future futureQuote;

  @override
  // Initialize the state by fetching a quote from the API
  void initState() {
    super.initState();
    futureQuote = fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 50, 10, 20),
              child: Text(
                'Hello, ${widget.name}!',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),

          // The Future object we got from fetching a quote is "built" here.
          FutureBuilder(
              future: futureQuote,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(
                        "An inspirational quote just for you!",
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
              })
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
