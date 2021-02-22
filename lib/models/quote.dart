import 'package:http/http.dart' as http;
import 'dart:convert';

/*
Here is an example of how to use an API.
In this scenario, I'm using an API to get random quotes (the randomization, by the way,
is done by the API, not me).
In order to make such requests, we'll need to import two things:

- http (I already included this in the pubspec.yaml file, so there is no need to install it again)
    Note that some packages must be installed by running `flutter pub get` in cmd, while others are already
    included in Dart's standard library.
- dart:convert (convert JSON response from the API to a dictionary, or a Map in Flutter)

Once we have imported both, we can finally start making requests!
*/

// This is an asyncrhonous function that returns a Future object.
Future fetchQuote() async {
  // This async await part is like the promises Riley worked on for the backend
  final response = await http.get('https://zenquotes.io/api/random');
  // print(response.body);
  if (response.statusCode == 200) {
    // Return an instance from the Quote class
    return Quote.fromJson(jsonDecode(response.body)[0]);
  } else {
    throw Exception(
        'Bummer! Failed to retrieve an inspriational quote for you.');
  }
}

class Quote {
  final String quoteText;
  final String author;
  Quote({this.quoteText, this.author});

  // Constructor for Quote class (specifically from JSON)
  factory Quote.fromJson(Map<String, dynamic> json) {
    if (json['q'].startsWith('Too many requests')) {
      throw Exception(
          "Woah! We can't generate quotes for you this quickly. Please slow down.");
    }
    return Quote(
      quoteText: json['q'],
      author: json['a'],
    );
  }
}
