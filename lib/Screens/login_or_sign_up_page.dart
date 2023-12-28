import 'package:flutter/material.dart';
import 'package:visitor_counting_system/Screens/login_page.dart';
import 'package:visitor_counting_system/Screens/sign_up_page.dart';

class LoginOrSignUpPage extends StatefulWidget {
  const LoginOrSignUpPage({super.key});

  @override
  State<LoginOrSignUpPage> createState() => _LoginOrSignUpPageState();
}

class _LoginOrSignUpPageState extends State<LoginOrSignUpPage> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  void showErrorMessage(String message) {}

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return SignUpPage(onTap: togglePages);
    }
  }
}
