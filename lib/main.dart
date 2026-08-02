import 'package:flutter/material.dart';
import 'package:guidance/screens/refer_students.dart';
import 'package:guidance/screens/guardian_dashboard.dart';
import 'package:guidance/screens/parent_dashboard.dart';
import 'package:guidance/screens/student_dashboard.dart';
import 'package:guidance/screens/faculty_dashboard.dart';
import 'package:guidance/screens/student_notifications.dart';
import 'package:guidance/screens/student_profile.dart';
import 'widgets/page/login_page.dart';
import 'utils/input_validators.dart';
import 'services/auth/login_users.dart';
import 'database/database_configuration.dart';
import 'services/auth/sessions.dart';

void main() async {
  await DatabaseConfiguration.initialize();
  runApp(
    MaterialApp(
      routes: {
        '/loginPage': (context) => LoginScreen(),
        '/studentDashboard': (context) => StudentDashboard(),
        '/parentDashboard': (context) => ParentDashboard(),
        '/guardianDashboard': (context) => GuardianDashboard(),
        '/facultyDashboard': (context) => FacultyDashboard(),
        '/referStudents': (context) => ReferStudents(),
        '/studentProfile': (context) => StudentProfile(),
        '/studentNotifications': (context) => StudentNotifications(),
      },
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ),
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

  String role = 'Student';

  final _loginKey = GlobalKey<FormState>();

  void login() async {
    if (!_loginKey.currentState!.validate()) {
      return;
    }

    // Logging in modal
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
          title: Text('Logging In'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Please wait'),
            ],
          ),
        );
      },
    );

    String login = await LoginUsers.loginUsers(
      emailController.text,
      passwordController.text,
      role,
    );

    if (context.mounted) {
      Navigator.of(context).pop();
    }

    if (login == 'loginStudent') {
      Navigator.pushReplacementNamed(context, '/studentDashboard');
      return;
    } else if (login == 'loginFaculty') {
      Navigator.pushReplacementNamed(context, '/facultyDashboard');
      return;
    } else if (login == 'loginParent') {
      Navigator.pushReplacementNamed(context, '/parentDashboard');
      return;
    } else if (login == 'loginGuardian') {
      Navigator.pushReplacementNamed(context, '/guardianDashboard');
      return;
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            contentTextStyle: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
            title: Text('Login Failed'),
            content: Text('Something went wrong'),
          );
        },
      );
    }
  }

  void checkSession() async {
    final session = await Sessions.validate();

    if (session == 'Student') {
      Navigator.pushReplacementNamed(context, '/studentDashboard');
      return;
    }

    if (session == 'Faculty') {
      Navigator.pushReplacementNamed(context, '/facultyDashboard');
      return;
    }

    if (session == 'Parent') {
      Navigator.pushReplacementNamed(context, '/parentDashboard');
      return;
    }

    if (session == 'Guardian') {
      Navigator.pushReplacementNamed(context, '/guardianDashboard');
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    checkSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoginPageContainer(
        selectedRole: role,
        roles: ['Student', 'Parent', 'Faculty', 'Guardian']
            .map((role) => DropdownMenuItem(value: role, child: Text(role)))
            .toList(),

        dropdownDisplay: (value) {
          setState(() {
            role = value ?? 'Student';
          });
        },
        passwordValidator: Validators.required,
        emailValidator: Validators.email,
        passwordController: passwordController,
        loginKey: _loginKey,
        emailController: emailController,
        login: login,
      ),
    );
  }
}
