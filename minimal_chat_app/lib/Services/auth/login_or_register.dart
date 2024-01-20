import 'package:flutter/material.dart';
import 'package:minimal_chat_app/Pages/login_page.dart';
import 'package:minimal_chat_app/Pages/register_page.dart';

class LoginorRegister extends StatefulWidget {
  const LoginorRegister({super.key});

  @override
  State<LoginorRegister> createState() => _LoginorRegisterState();
}

class _LoginorRegisterState extends State<LoginorRegister> {
  // initially, show login page
  bool showLoginPage = true;

  // toggle between login and register page
  void togglePages() {
    setState(() {
      print("on lick 1 time is: $showLoginPage");
      showLoginPage = !showLoginPage;
      print("on lick 2 time is: $showLoginPage");
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
