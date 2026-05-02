
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:services/layout/login.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
  static var usid = "";
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController name, phoneNumber, address, email,username,password;
  late List data;
  bool isLoading = true;  // Track loading state

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    phoneNumber = TextEditingController();
    address = TextEditingController();
    email = TextEditingController();
    username = TextEditingController();
    password = TextEditingController();
    fetchUserData();
  }

  void fetchUserData() async {
    var url = Uri.parse(Login.url + "user/view/");
    Response resp1 = await post(url, body: {
      "usid": Login.uid.toString(),
    });

    if (resp1.statusCode == 200) {
      data = jsonDecode(resp1.body);
      setState(() {
        name.text = data[0]["name"].toString();
        phoneNumber.text = data[0]["phone"].toString();
        address.text = data[0]["address"].toString();
        email.text = data[0]["email"].toString();
        username.text = data[0]["username"].toString();
        password.text = data[0]["password"].toString();
        isLoading = false; // Stop loading after data is fetched
      });
    } else {
      // Handle error if response is not successful
      setState(() {
        isLoading = false;
      });
      print('Error fetching data: ${resp1.statusCode}');
    }
  }

  void postData() async {
    var url = Uri.parse(Login.url + "user/update/");

    var resp = await post(url, body: {
      "usid": Login.uid.toString(),
      "name": name.text,
      "phone": phoneNumber.text,
      "address": address.text,
      "email": email.text,
      "username": username.text,
      "password": password.text,

    });

    if (resp.statusCode == 200) {
      // Successfully updated
      print('Profile updated successfully');
      Navigator.of(context).pop(); // Navigate back after update
    } else {
      // Handle error if update fails
      print('Failed to update profile: ${resp.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/b.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [

                /// 🔥 TITLE
                const SizedBox(height: 30),
                Text(
                  "Update Profile",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 20),

                /// 👤 PROFILE ICON
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.teal,
                  ),
                ),

                const SizedBox(height: 20),

                /// 📄 FORM CARD
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white.withOpacity(0.95),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      )
                    ],
                  ),
                  child: Column(
                    children: [

                      if (isLoading)
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(),
                        )
                      else ...[

                        /// NAME
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            controller: name,
                            decoration: InputDecoration(
                              labelText: "Name",
                              prefixIcon: Icon(Icons.person, color: Colors.teal),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),

                        /// PHONE
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            controller: phoneNumber,
                            decoration: InputDecoration(
                              labelText: "Phone Number",
                              prefixIcon: Icon(Icons.phone, color: Colors.teal),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),

                        /// ADDRESS
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            controller: address,
                            decoration: InputDecoration(
                              labelText: "Address",
                              prefixIcon: Icon(Icons.location_on, color: Colors.teal),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),

                        /// USERNAME
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            controller: username,
                            decoration: InputDecoration(
                              labelText: "Username",
                              prefixIcon: Icon(Icons.account_circle, color: Colors.teal),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),

                        /// PASSWORD
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            controller: password,
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(Icons.lock, color: Colors.teal),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),

                        /// EMAIL
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(Icons.email, color: Colors.teal),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// 🚀 UPDATE BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              postData();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              "Update",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}