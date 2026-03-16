import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nako po'),),
      body: ElevatedButton(onPressed: () {
        Navigator.pushReplacementNamed(context, '/register');
      }, child: Text('Register')),
    );
  }
}