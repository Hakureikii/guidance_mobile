import 'package:flutter/material.dart';
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

  // ── Unchanged logic ───────────────────────────────────────────────────────────

  void _register() async {
    final Uri url = Uri.parse(
      'http://127.0.0.1/Research_Backup/register_users.html',
    );
    launchUrl(url);
  }

  // ── Shared input decoration ───────────────────────────────────────────────────

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 13,
        color: Colors.black.withOpacity(0.3),
      ),
      prefixIcon: Icon(icon, color: Color(0xFF048c6c), size: 18),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 0.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFF048c6c), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
      ),
      errorStyle: TextStyle(fontFamily: 'Poppins', fontSize: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF048c6c),
      body: SafeArea(
        child: Column(
          children: [
            // ── Hero top half ──────────────────────────────────────────────────
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.25),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.school_outlined,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),

                    SizedBox(height: 16),

                    Text(
                      'Guidance Counseling\nManagement System',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      'Sign in to access your account',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.65),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Form bottom half ───────────────────────────────────────────────
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF4F6F5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20, 28, 20, 20),
                  child: Form(
                    key: widget.loginKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // ── Email ──────────────────────────────────────────────
                        _fieldLabel('Email'),
                        SizedBox(height: 6),
                        TextFormField(
                          controller: widget.emailController,
                          validator: widget.emailValidator,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                          decoration: _inputDecoration(
                            hint: 'sample@gmail.com',
                            icon: Icons.email_outlined,
                          ),
                        ),

                        SizedBox(height: 14),

                        // ── Password ───────────────────────────────────────────
                        _fieldLabel('Password'),
                        SizedBox(height: 6),
                        TextFormField(
                          controller: widget.passwordController,
                          validator: widget.passwordValidator,
                          obscureText: isObscured,
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                          decoration: _inputDecoration(
                            hint: '••••••••',
                            icon: Icons.lock_outline,
                            suffixIcon: IconButton(
                              icon: Icon(
                                isObscured
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Color(0xFF888780),
                                size: 18,
                              ),
                              onPressed: () {
                                setState(() => isObscured = !isObscured);
                              },
                            ),
                          ),
                        ),

                        SizedBox(height: 14),

                        // ── Role dropdown ──────────────────────────────────────
                        _fieldLabel('Role'),
                        SizedBox(height: 6),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.black.withOpacity(0.1),
                              width: 0.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.group_outlined,
                                color: Color(0xFF048c6c),
                                size: 18,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                                  value: widget.selectedRole,
                                  items: widget.roles,
                                  onChanged: widget.dropdownDisplay,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Color(0xFF888780),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24),

                        // ── Login button ───────────────────────────────────────
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: widget.login,
                            icon: Icon(Icons.login_rounded, size: 18),
                            label: Text(
                              'LOGIN',
                              style: TextStyle(
                                letterSpacing: 2,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF048c6c),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 16),

                        // ── Register link ──────────────────────────────────────
                        Center(
                          child: TextButton(
                            onPressed: _register,
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Don't have an account? ",
                                    style: TextStyle(
                                      color: Color(0xFF888780),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Register here',
                                    style: TextStyle(
                                      color: Color(0xFF048c6c),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Field label ───────────────────────────────────────────────────────────────

  Widget _fieldLabel(String label) {
    return Text(
      label.toUpperCase(),
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Color(0xFF888780),
        letterSpacing: 0.7,
      ),
    );
  }
}