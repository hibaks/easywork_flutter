import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:services/layout/login.dart';

class FeedbackPage extends StatefulWidget {


  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

  TextEditingController commentController = TextEditingController();
  double rating = 3;


  Future<void> sendFeedback() async {
    var url = Uri.parse(Login.url+"feedback/feedback/");

    var response = await http.post(
      url,
      body: {
        "comment": commentController.text,
        "review": rating.toString(),
        "user_id": Login.uid.toString()
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Feedback Submitted")),
      );
      commentController.clear();
      setState(() {
        rating = 3;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to submit")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Give Feedback"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    const Icon(
                      Icons.feedback,
                      size: 60,
                      color: Colors.teal,
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Share Your Experience",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// COMMENT BOX
                    TextField(
                      controller: commentController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: "Write your feedback",
                        prefixIcon: const Icon(Icons.edit),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// RATING DISPLAY
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Rating",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "${rating.toInt()} / 5",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),

                    /// SLIDER
                    Slider(
                      value: rating,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      activeColor: Colors.teal,
                      label: rating.toString(),
                      onChanged: (value) {
                        setState(() {
                          rating = value;
                        });
                      },
                    ),

                    const SizedBox(height: 25),

                    /// SUBMIT BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: sendFeedback,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          "Submit Feedback",
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