import 'package:flutter/material.dart';
import '../custom_field.dart';

class OTPContainer extends StatefulWidget {
  final VoidCallback? signIn;

  final FormFieldValidator<String?> otpValidator;
  final GlobalKey<FormState> otpKey;

  const OTPContainer({
    super.key,

    required this.signIn,
    required this.otpValidator,
    required this.otpKey,

    // required this.sendOtp,
  });

  @override
  State<OTPContainer> createState() => _OTPContainerState();
}

class _OTPContainerState extends State<OTPContainer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,

        child: Column(
          children: [
            // Header container
            Container(
              height: MediaQuery.of(context).size.height * 0.10,
              color: Color(0xFF18c89f),
              child: Center(
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
              ),
            ),

            //Body header text
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
              width: double.infinity,
              child: Text(
                textAlign: TextAlign.start,
                'Enter your OTP',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Body Subtext
            Container(
              padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
              width: double.infinity,
              child: Text(
                'Please enter the code sent to you via email. Make sure to never share your One-Time Password (OTP) or verification code with anyone, including bank employees, family, or friends.',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
            ),

            Form(
              key: widget.otpKey,
              child: Container(
                padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                child: CustomField(
                  validator: widget.otpValidator,
                  hint: "Enter your 8-digit code here",
                  icon: Icons.password,
                  label: 'OTP',
                  readOnly: false,
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: 20),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
                child: Text("Don't have an account? Register here"),
              ),
            ),

            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 20),
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 70),
                    backgroundColor: Color(0xFF048c6c),
                    foregroundColor: Colors.white,
                    shape: BeveledRectangleBorder(),
                  ),
                  onPressed: widget.signIn,
                  child: Text(
                    'Sign In',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
