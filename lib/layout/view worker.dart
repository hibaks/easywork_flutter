// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'login.dart';
//
// class WorkerPage extends StatefulWidget {
//   const WorkerPage({super.key});
//
//   @override
//   State<WorkerPage> createState() => _WorkerPageState();
// }
//
// class _WorkerPageState extends State<WorkerPage> {
//
//   List workers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchWorkers();
//   }
//
//   void fetchWorkers() async {
//     var url = Uri.parse(Login.url + "worker/view/");
//
//     var response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       setState(() {
//         workers = jsonDecode(response.body);
//       });
//     }
//   }
//
//   void bookWorker(String workerId) async {
//     var url = Uri.parse(Login.url + "booking/book/");
//
//     var response = await http.post(url, body: {
//       "user_id": Login.uid.toString(),
//       "service_id": workerId
//     });
//
//     if (response.statusCode == 200) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Booked Successfully")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Workers"),
//         centerTitle: true,
//         backgroundColor: Colors.teal,
//         elevation: 0,
//       ),
//
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.teal.shade100, Colors.white],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//
//         child: workers.isEmpty
//             ? const Center(child: CircularProgressIndicator())
//             : ListView.builder(
//           itemCount: workers.length,
//           itemBuilder: (context, index) {
//
//             var worker = workers[index];
//
//             return Container(
//               margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//               padding: const EdgeInsets.all(15),
//
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 8,
//                     offset: Offset(0, 4),
//                   )
//                 ],
//               ),
//
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   /// 👤 NAME + ICON
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 25,
//                         backgroundColor: Colors.teal.shade100,
//                         child: const Icon(Icons.person, color: Colors.teal),
//                       ),
//                       const SizedBox(width: 12),
//
//                       Expanded(
//                         child: Text(
//                           worker['name'].toString(),
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 12),
//
//                   /// 📞 CONTACT
//                   Row(
//                     children: [
//                       const Icon(Icons.phone, size: 18, color: Colors.grey),
//                       const SizedBox(width: 8),
//                       Text("Contact: ${worker['contact']}"),
//                     ],
//                   ),
//
//                   const SizedBox(height: 6),
//
//                   /// 🛠 SKILL
//                   Row(
//                     children: [
//                       const Icon(Icons.build, size: 18, color: Colors.grey),
//                       const SizedBox(width: 8),
//                       Text("Skill: ${worker['specialization']}"),
//                     ],
//                   ),
//
//                   const SizedBox(height: 6),
//
//                   /// ⏰ AVAILABILITY
//                   Row(
//                     children: [
//                       const Icon(Icons.access_time, size: 18, color: Colors.grey),
//                       const SizedBox(width: 8),
//                       Text("Available: ${worker['availability']}"),
//                     ],
//                   ),
//
//                   const SizedBox(height: 15),
//
//                   /// 🚀 BOOK BUTTON
//                   SizedBox(
//                     width: double.infinity,
//                     height: 45,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         bookWorker(worker['worker_id'].toString());
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.teal,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text(
//                         "Book Now",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'login.dart';

class WorkerPage extends StatefulWidget {
  const WorkerPage({super.key});

  @override
  State<WorkerPage> createState() => _WorkerPageState();
}

class _WorkerPageState extends State<WorkerPage> {

  List<dynamic> services = [];   // ✅ FIXED TYPE
  bool isLoading = true;         // ✅ LOADING CONTROL

  @override
  void initState() {
    super.initState();
    fetchServices();
  }

  // ✅ FETCH SERVICES (SAFE)
  void fetchServices() async {
    try {
      var url = Uri.parse(Login.url + "worker/view/");
      var response = await http.get(url);

      print(response.body); // 🔍 DEBUG

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // ✅ HANDLE BOTH CASES (list OR object)
        if (data is List) {
          setState(() {
            services = data;
            isLoading = false;
          });
        } else if (data is Map && data.containsKey('data')) {
          setState(() {
            services = data['data'];
            isLoading = false;
          });
        } else {
          setState(() {
            services = [];
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("ERROR: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // ✅ BOOK SERVICE
  void bookWorker(String serviceId) async {
    var url = Uri.parse(Login.url + "booking/book/");

    var response = await http.post(url, body: {
      "user_id": Login.uid.toString(),
      "service_id": serviceId
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Booked Successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Booking Failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Services"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: isLoading
            ? const Center(child: CircularProgressIndicator())

            : services.isEmpty
            ? const Center(child: Text("No Services Available"))

            : ListView.builder(
          itemCount: services.length,
          itemBuilder: (context, index) {

            var service = services[index];

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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

                  /// 👤 WORKER NAME
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.teal.shade100,
                        child: const Icon(Icons.person, color: Colors.teal),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          service['worker_name']?.toString() ?? "No Name",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// 🛠 SERVICE NAME
                  Text(
                    "Service: ${service['service_name'] ?? ''}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 5),

                  /// 💰 PRICE
                  Text("Price: ₹${service['price'] ?? ''}"),

                  const SizedBox(height: 5),

                  /// 📄 DESCRIPTION
                  Text("Description: ${service['description'] ?? ''}"),

                  const SizedBox(height: 8),

                  /// 📞 CONTACT
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 18, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(service['worker_contact'] ?? ''),
                    ],
                  ),

                  const SizedBox(height: 6),

                  /// 🧠 SKILL
                  Row(
                    children: [
                      const Icon(Icons.build, size: 18, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(service['worker_skill'] ?? ''),
                    ],
                  ),

                  const SizedBox(height: 6),

                  /// ⏰ AVAILABILITY
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 18, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(service['availability'] ?? ''),
                    ],
                  ),

                  const SizedBox(height: 15),

                  /// 🚀 BOOK BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
            onPressed: () {
            bookWorker(service['service_id'].toString());
            },
                          // : null,   // ❌ disabled if not available

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      child: const Text(
                        "Book Now",
                        style: TextStyle(fontWeight: FontWeight.bold),
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