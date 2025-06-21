import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'diary_page_view.dart';
import 'utils.dart';

class DiaryEntries extends StatelessWidget {
  const DiaryEntries({super.key});

  String trimTo15Letters(String text) {
    if (text.length <= 50) return text;
    return text.substring(0, 50) + '...';
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('my-diary').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
      
            if (snapshot.hasError) {
              return Center(child: Text("Some error occurred while fetching entries."));
            }
      
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text("No diary entries found."));
            }
      
            final docs = snapshot.data!.docs;
      
            return SingleChildScrollView(
              child: Center(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(docs.length, (index){
                    final data = docs[index].data() as Map<String, dynamic>;
                    final title = data['title'] ?? '';
                    final tea = data['tea'] ?? '';
                    final mood = data['mood'] ?? '';
                    DateTime date = (data['date'] as Timestamp).toDate();
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DiaryPageView(title: title, tea: tea, mood: mood, date: date),));
                      },
                      child: Container(
                        width: 350,
                        height: 140,
                        decoration: BoxDecoration(
                            color: getMoodColor(mood),
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(trimTo15Letters(title), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),),
                              Text("${date.day}, ${DateFormat('MMMM').format(date)} ${date.year}",
                                style: TextStyle(color: Colors.black54),),
                              SizedBox(height: 4,),
                              Text(trimTo15Letters(tea), style: TextStyle(color: Colors.white, fontSize: 16),),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
