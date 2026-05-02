import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:services/layout/login.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController address;
  late TextEditingController username;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    address = TextEditingController();
    username = TextEditingController();
    password = TextEditingController();
  }

  Future<void> postdata() async {
    // ✅ VALIDATION START
    if (name.text.isEmpty ||
        email.text.isEmpty ||
        phone.text.isEmpty ||
        address.text.isEmpty ||
        username.text.isEmpty ||
        password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    // Email validation
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid email")),
      );
      return;
    }

    // Phone validation (10 digits)
    if (!RegExp(r'^[0-9]{10}$').hasMatch(phone.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid 10-digit phone number")),
      );
      return;
    }

    // Password validation
    if (password.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password must be at least 6 characters")),
      );
      return;
    }
    // ✅ VALIDATION END


    var url = Uri.parse(Login.url + "user/flu/");

    Response resp = await post(url, body: {
      'name': name.text,
      'email': email.text,
      'phone': phone.text,
      'address': address.text,
      'username': username.text,
      'password': password.text,
    });

    if (resp.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration Success")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Login()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration Failed")),
      );
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

                    /// ICON
                    const Icon(
                      Icons.person_add,
                      size: 70,
                      color: Colors.teal,
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    _buildTextField(name, "Name", icon: Icons.person),
                    _buildTextField(email, "Email", icon: Icons.email),
                    _buildTextField(phone, "Phone", icon: Icons.phone),
                    _buildTextField(address, "Address", icon: Icons.home),
                    _buildTextField(
                        username, "Username", icon: Icons.account_circle),
                    _buildTextField(password, "Password",
                        obscure: true, icon: Icons.lock),

                    const SizedBox(height: 25),

                    /// REGISTER BUTTON
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
                        ),
                        child: const Text(
                          "Register",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// BACK BUTTON
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const Login()),
                        );
                      },
                      child: const Text("Already have an account? Login"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// UPDATED TEXTFIELD DESIGN
  Widget _buildTextField(TextEditingController controller,
      String label, {
        bool obscure = false,
        IconData? icon,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}