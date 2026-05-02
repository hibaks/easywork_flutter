import 'package:flutter/material.dart';
import 'package:services/layout/botnav.dart';
import 'package:services/layout/complaint.dart';
import 'package:services/layout/feedback.dart';
import 'package:services/layout/login.dart';
import 'package:services/layout/register.dart';
import 'package:services/layout/review.dart';
import 'package:services/layout/usermain.dart';
import 'package:services/layout/view%20booking%20status.dart';
import 'package:services/layout/view profile.dart';

import 'package:services/layout/view%20worker.dart';
import 'package:services/layout/view_service.dart';
import 'package:services/layout/worker_reply.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/':(context)=>const Login(),
      '/user_page':(context)=>const user_page(),
      '/complaint':(context)=>ComplaintPage(),
      '/ff':(context)=> const FeedbackPage(),
      '/register':(context) =>const UserRegistration(),
      '/rr':(context) =>const ReviewPage(),
      '/edit':(context) =>const EditProfile(),
      '/work':(context) =>const WorkerPage(),
      '/uu':(context) =>const ViewReplyPage(),
      '/ss': (context) => const StatusPage(),
      '/cc': (context) => const ServicePage(),

    },
  ));
}