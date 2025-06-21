import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'quotes.dart';
import 'utils.dart';

class DiaryPage extends StatefulWidget {
  final String mood;
  final DateTime date;

  DiaryPage({super.key, required this.mood, required this.date});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController diaryController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final moodColor = getMoodColor(widget.mood);
    final formattedDate = "${widget.date.day}, ${DateFormat('MMMM').format(widget.date)} ${widget.date.year}";

    return Scaffold(
      backgroundColor: const Color(0xFFF9F5F0), // soft paper-like background
      appBar: AppBar(
        title: const Text("Tell me more..."),
        backgroundColor: moodColor,
        elevation: 0,
      ),
      body: !isLoading ? Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: getMoodColor(widget.mood).withOpacity(0.15),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Mood: ${widget.mood}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: moodColor,
                ),
              ),
              const Divider(height: 24, thickness: 1),

              TextField(
                controller: titleController,
                maxLines: 1,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: "One word to describe...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                ),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: TextField(
                  controller: diaryController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(fontSize: 18, height: 1.6),
                  decoration: InputDecoration(
                    hintText: "Pour your thoughts here...",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                  ),
                ),
              ),
            ],
          ),
        )
      ) : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: moodColor,
        onPressed: () {
          if(titleController.text.trim().isEmpty || diaryController.text.trim().isEmpty){
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text("Invalid Input"),
                content: Text("Input is empty or just whitespace."),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("OK"),
                  ),
                ],
              ),
            );
          }
          else {
            setState(() {
              isLoading = true;
            });
            CollectionReference diary = FirebaseFirestore.instance.collection(
                'my-diary');
            diary.add({
              'title': titleController.text.trim(),
              'tea': diaryController.text.trim(),
              'date': Timestamp.fromDate(widget.date),
              'mood': widget.mood,
            }).then((value) {
              print("Diary Added");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => QuotesPage(mood: widget.mood)),
              );
            }).catchError((error) => print("Failed to add diary: $error"));
          }
        },
        child: const Icon(Icons.done, color: Colors.white),
      ),
    );
  }
}
