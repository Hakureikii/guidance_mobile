import 'package:flutter/material.dart';
import '../custom_field.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPageContainer extends StatefulWidget {
  final VoidCallback login;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final GlobalKey<FormState> loginKey;

  final FormFieldValidator<String?> emailValidator;
  final FormFieldValidator<String?> passwordValidator;

  final List<DropdownMenuItem<String>>? roles;

  final String? selectedRole;

  final ValueChanged<String?> dropdownDisplay;

  const LoginPageContainer({
    super.key,

    this.roles,
    this.selectedRole,
    required this.dropdownDisplay,

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

  bool isObscured = true;
  
  void _register() async {
  final Uri url = Uri.parse('http://172.29.201.215/Research_Web/register_users.html');
  launchUrl(url);
}

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
                    'AI-',
                    style: TextStyle(
                      letterSpacing: 2,
                      color: Colors.black,
                      fontFamily: 'ShareTech',
                      fontWeight: FontWeight.w900,
                      fontSize: 50,
                    ),
                  ),
                  Text(
                    'GO',
                    style: TextStyle(
                      letterSpacing: 2,
                      color: Color(0xFF048c6c),
                      fontFamily: 'ShareTech',
                      fontWeight: FontWeight.w900,
                      fontSize: 50,
                    ),
                  ),
                ],
              ),

              Text(
                '愛-護',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
              ),

              SizedBox(height: 40),

              // Input Fields
              Form(
                key: widget.loginKey,
                child: Column(
                  children: [
                    CustomField(
                      isObscured: false,
                      textController: widget.emailController,
                      validator: widget.emailValidator,
                      icon: Icons.email,
                      hint: 'sample@gmail.com',
                      label: 'email',
                      readOnly: false,
                    ),

                    SizedBox(height: 15),

                    PasswordField(
                    validator: widget.passwordValidator,
                      passwordToggle: () {
                        setState(() {
                          isObscured == false ? isObscured = true : isObscured = false;
                          
                        });
                      },
                      isObscured: isObscured,
                      textController: widget.passwordController,
                      icon: Icons.password,
                      hint: '********',
                      label: 'password',
                    ),

                    SizedBox(height: 30),

                    Text(
                      'ROLE',
                      style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ShareTech'
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(Icons.group)
                          ),

                        Container(
                          padding: EdgeInsets.only(left: 5),
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                            value: widget.selectedRole,
                            items: widget.roles,
                            onChanged: widget.dropdownDisplay,
                            icon: Icon(Icons.menu),
                            alignment: Alignment.centerRight,
                          
                          ),
                        ),
                      ],
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
                onPressed: _register,
                child: Text(
                  "Don't have an account? Register here",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
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
