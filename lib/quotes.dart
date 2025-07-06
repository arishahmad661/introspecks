import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'utils.dart';

class QuotesPage extends StatelessWidget {
  String mood;
  QuotesPage({super.key, required this.mood});

  @override
  Widget build(BuildContext context) {

    final List<Color> cardColors = [
      Color.fromARGB(255,130,119,23),
      Color.fromARGB(255,0,77,64),
      Color.fromARGB(255,239,108,0),
      Color.fromARGB(255,25,35,54),
      Color.fromARGB(255,148, 116, 67),
    ];

    String tagForAPICall(String mood) {
      if (mood == "Suffering :)") {
        return "life";
      } else if (mood == "baddd") {
        return "wisdom";
      } else if (mood == "meh -_-") {
        return "inspirational";
      } else if (mood == "good") {
        return "motivational";
      } else if (mood == "happy happy happy") {
        return "happiness";
      }
      return "life"; // default tag
    }

    Future fetchQuotes() async {
      String tag = tagForAPICall(mood);
      final response = await http.get(
        Uri.parse('$BASE_URL/quotes?tags=$tag&limit=$Quote_Limit'),
      );
      final List data = jsonDecode(response.body)['results'];
      final quotes = data.map((quote) => {'quote': quote['content'], 'author': quote['author'],},).toList();
      return quotes;
    }

    Color getTextColor(Color bg) {
      final brightness = bg.computeLuminance();
      return brightness < 0.5 ? Colors.white : Colors.black87;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9F5F0), // soft paper-like background
      appBar: AppBar(
        title: Row(
          children: [
            Text("🪞 "),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.deepPurpleAccent, Colors.purpleAccent],
              ).createShader(bounds),
              child: const Text(
                "Introspee",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: fetchQuotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final quotes = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  itemCount: quotes.length,
                  itemBuilder: (context, index) {
                    final bgColor = cardColors[index % cardColors.length];
                    final quote = quotes[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color:bgColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                                child: Text("❞", style: TextStyle(fontSize: 32, color:getTextColor(bgColor)),)
                            ),
                            Text(
                              '"${quote['quote']}"',
                              style: TextStyle(
                                fontSize: 18,
                                  color:getTextColor(bgColor)
                              ),
                            ),
                            SizedBox(height: 12),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "- ${quote['author']}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error in the data received"));
            } else {
              return Center(
                child: Text("Some error occurred in fetched item."),
              );
            }
          } else {
            return Center(
              child: Text("Some error occurred in fetching quotes data."),
            );
          }
        },
      ),
    );
  }
}
