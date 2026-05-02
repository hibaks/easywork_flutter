
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:services/layout/register.dart';
import 'package:services/layout/usermain.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
  static var url="http://192.168.1.34:8000/";
  static var uid;
}

class _LoginState extends State<Login> {
  late TextEditingController username,password;
  var data=[];

  @override
  void initState(){
    username=TextEditingController();
    password=TextEditingController();
    super.initState();
  }
  void postdata()async{
    var url=Uri.parse(Login.url+"login/login_app/");
    Response resp =await post(url,body: {
      "username":username.text,
      "password":password.text
    });
    data = jsonDecode(resp.body);
    if (data.length > 0)
    {
      Login.uid = data[0]['u_id'].toString();
      if (data[0]['type'] == "user")
      {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext) => user_page()));
        showDialog(context: context, builder: (context) => AlertDialog(
            content: Text("you have successfully logged in")));
      }
      // else if (data[0]['type'] == "agent")
      // {
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (BuildContext) => agentmain()));
      //   showDialog(context: context, builder: (context) => AlertDialog(
      //       content: Text("you have successfully logged in")));
      // }
      // else if (data[0]['type'] == "user")
      // {
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (BuildContext) => user_draw()));
      //   showDialog(context: context, builder: (context) => AlertDialog(
      //       content: Text("you have successfully logged in")));
      // }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

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

                    /// LOGO / ICON
                    const Icon(
                      Icons.lock,
                      size: 70,
                      color: Colors.teal,
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// USERNAME FIELD
                    TextFormField(
                      controller: username,
                      decoration: InputDecoration(
                        labelText: 'Username',
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

                    /// PASSWORD FIELD
                    TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// LOGIN BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: postdata,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// REGISTER BUTTON
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext) => UserRegistration()));
                      },
                      child: const Text(
                        "Don't have an account? Register",
                        style: TextStyle(fontSize: 14),
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
