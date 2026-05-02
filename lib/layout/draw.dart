import 'package:flutter/material.dart';
import 'package:services/layout/login.dart';

class draw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('asset/images (1).png'),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            _buildDrawerItem(
              icon: Icons.school,
              text: 'Home',
              onTap: () {
                Navigator.pushNamed(context, '/mainpage');
              },
            ),

            _buildDrawerItem(
              icon: Icons.notification_add,
              text: 'Post Complaints',
              onTap: () {
                Navigator.pushNamed(context, '/complaint');
              },
            ),

            _buildDrawerItem(
              icon: Icons.event_note_outlined,
              text: 'Feedback',
              onTap: () {
                Navigator.pushNamed(context, '/ff');
              },
            ),

            _buildDrawerItem(
              icon: Icons.feed_sharp,
              text: 'Review',
              onTap: () {
                Navigator.pushNamed(context, '/rr');
              },
            ),

            _buildDrawerItem(
              icon: Icons.notification_add,
              text: 'Profile',
              onTap: () {
                Navigator.pushNamed(context, '/edit');
              },
            ),
            _buildDrawerItem(
              icon: Icons.notification_add,
              text: 'view worker',
              onTap: () {
                Navigator.pushNamed(context, '/work');
              },
            ),
            _buildDrawerItem(
              icon: Icons.notification_add,
              text: 'View Reply',
              onTap: () {
                Navigator.pushNamed(context, '/uu');
              },
            ),
            _buildDrawerItem(
              icon: Icons.check_circle,
              text: 'Booking Status',
              onTap: () {
                Navigator.pushNamed(context, '/ss');
              },
            ),
            _buildDrawerItem(
              icon: Icons.check_circle,
              text: 'Services',
              onTap: () {
                Navigator.pushNamed(context, '/cc');
              },
            ),

            // _buildDrawerItem(
            //   icon: Icons.feed_sharp,
            //   text: 'Feedback',
            //   onTap: () {
            //     Navigator.pushNamed(context, '/feedback');
            //   },
            // ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => Login(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}
