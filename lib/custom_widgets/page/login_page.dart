import 'package:flutter/material.dart';
import '../custom_field.dart';
// import 'package:url_launcher/url_launcher.dart';

class LoginPageContainer extends StatefulWidget {
  final VoidCallback login;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final GlobalKey<FormState> loginKey;

  final FormFieldValidator<String?> emailValidator;
  final FormFieldValidator<String?> passwordValidator;

  const LoginPageContainer({
    super.key,

    required this.emailValidator,
    required this.passwordValidator,

    required this.loginKey,

    required this.emailController,
    required this.passwordController,
    required this.login,
  });

  @override
  State<LoginPageContainer> createState() => LoginPageContainerState();
}

class LoginPageContainerState extends State<LoginPageContainer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'AI',
                    style: TextStyle(
                      letterSpacing: 2,
                      color: Colors.black,
                      fontFamily: 'ShareTech',
                      fontWeight: FontWeight.w900,
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'COMPANION',
                    style: TextStyle(
                      letterSpacing: 2,
                      color: Color(0xFF048c6c),
                      fontFamily: 'ShareTech',
                      fontWeight: FontWeight.w900,
                      fontSize: 32,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40),

              // Input Fields
              Form(
                key: widget.loginKey,
                child: Column(
                  children: [
                    CustomField(
                      textController: widget.emailController,
                      validator: widget.emailValidator,
                      icon: Icons.email,
                      hint: 'sample@gmail.com',
                      label: 'email',
                      readOnly: false,
                    ),

                    SizedBox(height: 15),

                    CustomField(
                      validator: widget.passwordValidator,
                      textController: widget.passwordController,
                      icon: Icons.password,
                      hint: '********',
                      label: 'password',
                      readOnly: false,
                    ),

                    SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: widget.login,
                      style: ElevatedButton.styleFrom(
                        shape: BeveledRectangleBorder(),
                        padding: EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 80,
                        ),
                        backgroundColor: Color(0xFF048c6c),
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          letterSpacing: 3,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Footer
              TextButton(
                onPressed: () {},
                child: Text(
                  "Don't have an account? Register here",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF048c6c),
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
