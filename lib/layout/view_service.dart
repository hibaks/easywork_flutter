import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {

  List services = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchServices();
  }

  /// 🔥 FETCH SERVICES
  Future<void> fetchServices() async {
    var url = Uri.parse(Login.url + "temp/view/");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        services = jsonDecode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// 🎨 CARD COLOR DESIGN
  Color getCardColor(int index) {
    List colors = [
      Colors.blue.shade100,
      Colors.green.shade100,
      Colors.orange.shade100,
      Colors.purple.shade100,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Services"),
        backgroundColor: Colors.teal,
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : services.isEmpty
          ? const Center(child: Text("No Services Found"))
          : ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {

          var item = services[index];

          return Container(
            margin: const EdgeInsets.all(10),
            child: Card(
              color: getCardColor(index),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// 🔹 SERVICE NAME
                    Text(
                      item['service_name'].toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// 🔹 DESCRIPTION
                    Text(
                      item['description'].toString(),
                    ),

                    const SizedBox(height: 10),

                    /// 💰 PRICE
                    Row(
                      children: [
                        const Icon(Icons.currency_rupee, size: 18),
                        Text(
                          item['price'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    /// 📊 STATUS
                    Row(
                      children: [
                        const Icon(Icons.info, size: 18),
                        const SizedBox(width: 5),
                        Text(
                          item['availability'].toString(),
                          style: TextStyle(
                            color: item['availability'] == "Available"
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}