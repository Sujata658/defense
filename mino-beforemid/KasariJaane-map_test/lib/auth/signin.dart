import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            //TODO : add logo and name here
            SizedBox(height: 120.0),
            // Email
            TextFormField(
              decoration: InputDecoration(labelText: "Email"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your email.";
                }
                return null;
              },
              onSaved: (value) => _email = value!,
            ),
            SizedBox(height: 12.0),
            // Password
            TextFormField(
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your password.";
                }
                return null;
              },
              onSaved: (value) => _password = value!,
            ),
            SizedBox(height: 24.0),
            // Sign up button
            ElevatedButton(
              child: Text("Sign Up"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                  // Perform authentication and save the user data
                }
              },
            ),
            SizedBox(height: 18.0),
            // Login link
            TextButton(
              child: Text("Already have an account? Login"),
              onPressed: () {
                // Navigate to the login page
              },
            ),
          ],
        ),
      ),
    );
  }
}
