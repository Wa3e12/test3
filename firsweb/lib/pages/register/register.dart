import 'package:firsweb/constants/style.dart';
import 'package:firsweb/database/database.dart';
import 'package:firsweb/layout.dart';
import 'package:firsweb/pages/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key});

  // Create FirebaseAuth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  // Variables to store ID and password
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // Function to handle login
  Future<void> _login(BuildContext context) async {
    try {
      // Sign in with email and password
      await _auth.createUserWithEmailAndPassword(
        email: _idController.text.trim() + "@example.com",
        password: _passwordController.text.trim(),
      );
      final User = _auth.currentUser;
      final uid = User!.uid;
      print(uid);
      await DatabassService(uid: uid).updateUserData(
          100.0,
          _idController.text.trim(),
          _idController.text.trim() + "@example.com");
      // If successful, navigate to home or next page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SiteLayout()),
      );
    } catch (e) {
      // Show error message if login fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login failed. Please check your credentials."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        key: _formKey,
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.offAll(() => AuthenticationPage());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: lightGrey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      width: 100,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "Back",
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 12),
                  ),
                  Expanded(child: Container())
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "Welcome to the IMAMU Digital Bank",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: "ID",
                  hintText: "44xxxxxxx",
                  hoverColor: active,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  _login(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: active,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
