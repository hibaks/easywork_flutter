import 'package:flutter/material.dart';
import 'package:services/layout/botnav.dart';
import 'package:services/layout/draw.dart';

class user_page extends StatefulWidget {
  const user_page({Key? key}) : super(key: key);

  @override
  State<user_page> createState() => _user_pageState();
}

class _user_pageState extends State<user_page> {
  var label = ['Home', 'Page1', 'Page2', 'Page3', 'Page4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      /// 🔷 APPBAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal,
        title: const Text(
          'EasyWork',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
      ),

      /// 📌 DRAWER
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: draw(),
        ),
      ),

      /// 🔻 BOTTOM NAV
      bottomNavigationBar: botnav_user(),

      /// 🏠 BODY
      body: SingleChildScrollView(
        child: Column(
          children: [

            /// 🔵 TOP HEADER WITH GRADIENT
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Hello 👋",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Welcome to EasyWork",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 🧩 QUICK ACTIONS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                physics: const NeverScrollableScrollPhysics(),
                children: [

                  _buildCard(Icons.person, "Profile", () {
                    Navigator.pushNamed(context, '/edit');
                  }),

                  _buildCard(Icons.work, "Workers", () {
                    Navigator.pushNamed(context, '/work');
                  }),

                  _buildCard(Icons.report, "Complaint", () {
                    Navigator.pushNamed(context, '/complaint');
                  }),

                  _buildCard(Icons.feedback, "Feedback", () {
                    Navigator.pushNamed(context, '/ff');
                  }),

                  _buildCard(Icons.rate_review, "Review", () {
                    Navigator.pushNamed(context, '/rr');
                  }),

                  _buildCard(Icons.message, "Replies", () {
                    Navigator.pushNamed(context, '/uu');
                  }),

                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 📢 INFO CARD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(Icons.info, color: Colors.blue, size: 30),
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          "Book trusted workers easily and manage your services in one place.",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// 🔹 REUSABLE CARD
  Widget _buildCard(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
