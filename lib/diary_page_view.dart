import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'utils.dart';

class DiaryPageView extends StatelessWidget {
  String title;
  String tea, mood;
  DateTime date;

  DiaryPageView({
    super.key,
    required this.title,
    required this.tea,
    required this.date,
    required this.mood,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = "${date.day}, ${DateFormat('MMMM').format(date)} ${date.year}";
    Color moodColor = getMoodColor(mood);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F5F0), // soft paper-like background
      appBar: AppBar(
        title: const Text("introspee"),
        backgroundColor: moodColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: getMoodColor(mood).withOpacity(0.15),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 10),

              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),
              const Divider(height: 30, thickness: 1.2),

              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    tea,
                    style: const TextStyle(
                      fontSize: 18,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
