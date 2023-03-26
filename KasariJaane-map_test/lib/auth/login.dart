import 'package:flutter/material.dart';
import 'package:kasarijaane/driver/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  void _submit() {
    final form = _formKey.currentState;
    form?.save();
    // validate form
    if (form!.validate()) {
      Navigator.push(context, MaterialPageRoute(
            builder: (context) =>DriverPage()),
      );
      print('email: $_email, password: $_password');
      // perform login operation here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
                obscureText: true,
                onSaved: (value) => _password = value!,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
