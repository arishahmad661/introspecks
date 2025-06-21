import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;

import 'diary_entries.dart';
import 'diary_page.dart';
import 'utils.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "How are you feeling today?",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Date picker
                ElevatedButton.icon(
                  onPressed: () {
                    picker.DatePicker.showDatePicker(
                      context,
                      currentTime: date,
                      onChanged: (dateTime) {
                        setState(() => date = dateTime);
                      },
                    );
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    DateFormat('d MMMM yyyy').format(date),
                    style: const TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),

                const SizedBox(height: 24),

                // Mood grid
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: moods.map((mood) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DiaryPage(
                              mood: mood["label"],
                              date: date,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: mood["color"],
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                mood["emoji"],
                                style: TextStyle(fontSize: 40),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  mood["label"],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ),
      ),

      // My Diary button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => DiaryEntries()));
        },
        backgroundColor: Colors.purpleAccent,
        icon: Icon(Icons.menu_book),
        label: Text("My Diary"),
      ),
    );
  }
}
