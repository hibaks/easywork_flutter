import 'package:flutter/material.dart';

class botnav_user extends StatefulWidget {
  const botnav_user({Key? key}) : super(key: key);

  @override
  State<botnav_user> createState() => _botnav_userState();
}

class _botnav_userState extends State<botnav_user> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (value) {
        setState(() {
          _currentIndex = value;
        });

        // ❗ No need Navigator.pop()
        if (value == 0) {
          Navigator.pushNamed(context, '/user_page');
        } else if (value == 1) {
          Navigator.pushNamed(context, '/complaint');
        } else if (value == 2) {
          Navigator.pushNamed(context, '/uu');
        } else if (value == 3) {
          Navigator.pushNamed(context, '/work');
        } else if (value == 4) {
          Navigator.pushNamed(context, '/ff');
        }
      },
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'Complaint',
          icon: Icon(Icons.report),
        ),
        BottomNavigationBarItem(
          label: 'Reply',
          icon: Icon(Icons.feedback),
        ),
        BottomNavigationBarItem(
          label: 'Workers',
          icon: Icon(Icons.people),
        ),
        BottomNavigationBarItem(
          label: 'Feedback',
          icon: Icon(Icons.star),
        ),
      ],
    );
  }
}