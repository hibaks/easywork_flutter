// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'login.dart';
//
// class StatusPage extends StatefulWidget {
//   const StatusPage({super.key});
//
//   @override
//   State<StatusPage> createState() => _StatusPageState();
// }
//
// class _StatusPageState extends State<StatusPage> {
//   List bookings = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchStatus();
//   }
//
//   Future<void> fetchStatus() async {
//     var url = Uri.parse(Login.url + "booking/status/");
//
//     var response = await http.post(
//       url,
//       body: {
//         "user_id": Login.uid.toString(),
//       },
//     );
//
//     if (response.statusCode == 200) {
//       setState(() {
//         bookings = jsonDecode(response.body);
//       });
//     }
//   }
//
//   /// 🎨 STATUS COLOR
//   Color getStatusColor(String status) {
//     if (status == "accept") return Colors.green;
//     if (status == "reject") return Colors.red;
//     return Colors.orange;
//   }
//
//   /// 🎯 STATUS ICON
//   IconData getStatusIcon(String status) {
//     if (status == "accept") return Icons.check_circle;
//     if (status == "reject") return Icons.cancel;
//     return Icons.access_time;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//
//       appBar: AppBar(
//         title: const Text("Booking Status"),
//         centerTitle: true,
//         backgroundColor: Colors.teal,
//         elevation: 0,
//       ),
//
//       body: bookings.isEmpty
//           ? const Center(
//         child: Text(
//           "No Bookings Found",
//           style: TextStyle(fontSize: 16),
//         ),
//       )
//           : ListView.builder(
//         itemCount: bookings.length,
//         padding: const EdgeInsets.all(10),
//         itemBuilder: (context, index) {
//           var item = bookings[index];
//
//           return Container(
//             margin: const EdgeInsets.only(bottom: 15),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.shade300,
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 )
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   /// 👷 Worker Name
//                   Row(
//                     children: [
//                       const Icon(Icons.person, color: Colors.teal),
//                       const SizedBox(width: 8),
//                       Text(
//                         item['worker_name'] ?? "No Worker",
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   /// 📅 Date
//                   Row(
//                     children: [
//                       const Icon(Icons.calendar_today, size: 18),
//                       const SizedBox(width: 8),
//                       Text("Date: ${item['date']}"),
//                     ],
//                   ),
//
//                   const SizedBox(height: 5),
//
//                   /// ⏰ Time
//                   Row(
//                     children: [
//                       const Icon(Icons.access_time, size: 18),
//                       const SizedBox(width: 8),
//                       Text("Time: ${item['time']}"),
//                     ],
//                   ),
//
//                   const SizedBox(height: 15),
//
//                   /// 📊 Status Badge
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 15, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: getStatusColor(item['status']),
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(
//                             getStatusIcon(item['status']),
//                             color: Colors.white,
//                             size: 18,
//                           ),
//                           const SizedBox(width: 5),
//                           Text(
//                             item['status'].toUpperCase(),
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  List bookings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStatus();
  }

  Future<void> fetchStatus() async {
    try {
      var url = Uri.parse(Login.url + "booking/status/");

      var response = await http.post(
        url,
        body: {
          "user_id": Login.uid.toString(),
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          bookings = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Color getStatusColor(String status) {
    if (status == "accept") return Colors.green;
    if (status == "reject") return Colors.red;
    return Colors.orange;
  }

  IconData getStatusIcon(String status) {
    if (status == "accept") return Icons.check_circle;
    if (status == "reject") return Icons.cancel;
    return Icons.access_time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Booking Status"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bookings.isEmpty
          ? const Center(
        child: Text(
          "No Bookings Found",
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: bookings.length,
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          var item = bookings[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// 👷 Worker Name
                Row(
                  children: [
                    const Icon(Icons.person, color: Colors.teal),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item['worker'] ?? "No Worker",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                /// 🛠 Service Name
                Row(
                  children: [
                    const Icon(Icons.build, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "Service: ${item['service_name'] ?? ''}",
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                /// 📅 Date
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 18),
                    const SizedBox(width: 8),
                    Text("Date: ${item['date']}"),
                  ],
                ),

                const SizedBox(height: 5),

                /// ⏰ Time
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 18),
                    const SizedBox(width: 8),
                    Text("Time: ${item['time']}"),
                  ],
                ),

                const SizedBox(height: 15),

                /// 📊 STATUS
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: getStatusColor(item['status']),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          getStatusIcon(item['status']),
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          item['status'].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}