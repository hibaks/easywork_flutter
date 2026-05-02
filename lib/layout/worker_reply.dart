import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'login.dart';

class ViewReplyPage extends StatefulWidget {
  const ViewReplyPage({super.key});

  @override
  State<ViewReplyPage> createState() => _ViewReplyPageState();
}

class _ViewReplyPageState extends State<ViewReplyPage> {

  List complaints = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchReplies();
  }

  // FETCH REPLIES
  void fetchReplies() async {
    var url = Uri.parse(Login.url + "complaint/view_reply/");

    var response = await http.post(url, body: {
      "user_id": Login.uid.toString()
    });

    if (response.statusCode == 200) {
      setState(() {
        complaints = jsonDecode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print("Error fetching replies");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Complaints"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : complaints.isEmpty
            ? const Center(
          child: Text(
            "No complaints found",
            style: TextStyle(fontSize: 16),
          ),
        )
            : ListView.builder(
          itemCount: complaints.length,
          itemBuilder: (context, index) {

            var item = complaints[index];

            return Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 15, vertical: 8),
              padding: const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 📝 COMPLAINT TITLE
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.teal.shade100,
                        child: const Icon(Icons.feedback,
                            color: Colors.teal),
                      ),
                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          item['complaint'].toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// 📅 DATE
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text("Date: ${item['date']}"),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// 💬 REPLY BOX
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item['reply'] == null ||
                          item['reply'].toString().isEmpty
                          ? "No reply yet"
                          : item['reply'].toString(),
                      style: TextStyle(
                        color: item['reply'] == null
                            ? Colors.red
                            : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}