import 'package:flutter/material.dart';
import 'package:guidance/templates/set_appointments.dart';
import 'package:guidance/templates/test/guidance_dashboard.dart';
import 'package:guidance/templates/test/parent_dashboard.dart';
import 'package:guidance/templates/test/student_dashboard.dart';
import 'package:guidance/templates/test/faculty_dashboard.dart';
import '../custom_widgets/page/login_page.dart';
import '../custom_widgets/input_validators.dart';
import '../services/auth/login_users.dart';
import '../services/database_configuration.dart';
import '../services/auth/sessions.dart';

void main() async {
  await DatabaseConfiguration.initialize();
  runApp(
    MaterialApp(
      routes: {
        '/loginPage': (context) => LoginScreen(),
        '/studentDashboard': (context) => StudentDashboard(),
        '/parentDashboard': (context) => ParentDashboard(),
        '/guidanceDashboard': (context) => GuidanceDashboard(),
        '/facultyDashboard': (context) => FacultyDashboard(),
        '/setAppointments': (context) => SetAppointments(),
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

    String login = await LoginUsers.loginUsers(
      emailController.text,
      passwordController.text,
      role,
    );
    if (login == 'loginStudent') {
      Navigator.pushReplacementNamed(context, '/studentDashboard');
    } else if (login == 'loginFaculty') {
      Navigator.pushReplacementNamed(context, '/facultyDashboard');
    } else if (login == 'loginParent') {
      debugPrint('Login Parent');
    } else {
      debugPrint(login);
    }
  }

  void checkSession () async {
    final session = await Sessions.validate();

    if (session == 'Student') {
      Navigator.pushReplacementNamed(context, '/studentDashboard');
      return;
    }

    if (session == 'Faculty') {
      Navigator.pushReplacementNamed(context, '/facultyDashboard');
    }
  }

  @override
  void initState () {
    super.initState();
    checkSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoginPageContainer(
        selectedRole: role,
        roles: ['Student', 'Parent', 'Faculty']
            .map((role) => DropdownMenuItem(value: role, child: Text(role)))
            .toList(),

        dropdownDisplay: (value) {
          setState(() {
            role = value ?? 'Student';
            debugPrint(role);
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
