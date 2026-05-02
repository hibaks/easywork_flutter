import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:services/layout/login.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {

  List workers = [];
  String? selectedWorkerId;

  TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchWorkers();
  }

  /// 🔥 FETCH WORKERS
  Future<void> fetchWorkers() async {
    var url = Uri.parse(Login.url + "feedback/get_workers/");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        workers = jsonDecode(response.body);
      });
    }
  }

  /// 🔥 SUBMIT REVIEW
  Future<void> sendReview() async {
    if (selectedWorkerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select Worker")),
      );
      return;
    }

    var url = Uri.parse(Login.url + "feedback/review/");

    var response = await http.post(
      url,
      body: {
        "review": reviewController.text,
        "user_id": Login.uid,              // ✅ logged user
        "worker_id": selectedWorkerId!,    // ✅ selected worker
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Review Submitted")),
      );

      reviewController.clear();
      setState(() {
        selectedWorkerId = null;
      });

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Write Review"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    /// ICON
                    const Icon(
                      Icons.rate_review,
                      size: 70,
                      color: Colors.teal,
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Give Your Review",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// 🔽 WORKER DROPDOWN
                    DropdownButtonFormField<String>(
                      value: selectedWorkerId,
                      hint: const Text("Select Worker"),
                      items: workers.map<DropdownMenuItem<String>>((worker) {
                        return DropdownMenuItem<String>(
                          value: worker['worker_id'].toString(),
                          child: Text(worker['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedWorkerId = value;
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// ✍️ REVIEW BOX
                    TextField(
                      controller: reviewController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: "Enter Review",
                        prefixIcon: const Icon(Icons.comment),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// 🚀 SUBMIT BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: sendReview,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "Submit Review",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}