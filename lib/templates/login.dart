import 'package:flutter/material.dart';
import '../custom_widgets/page/login_page.dart';
import '../custom_widgets/input_validators.dart';
import '../services/auth/login_users.dart';
import '../services/database_configuration.dart';

void main () async {
  await DatabaseConfiguration.initialize();
  runApp(
    MaterialApp(
      routes: {},
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    )
    );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _loginKey = GlobalKey<FormState>();

  void login() async {
    if (!_loginKey.currentState!.validate()) {
      return;
    }

    bool isValidated = await LoginUsers.loginUsers(emailController.text, passwordController.text);
    if (isValidated == true) {
      debugPrint('Login ka na bai');
      
    } else {
      debugPrint('Nako po bai');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: LoginPageContainer(
          passwordValidator: Validators.required,
          emailValidator: Validators.email, 
          passwordController: passwordController,
          loginKey: _loginKey, 
          emailController: emailController, 
          login: login
          )
    );
  }
}
