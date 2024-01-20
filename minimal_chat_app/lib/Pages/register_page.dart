import 'package:flutter/material.dart';
import 'package:minimal_chat_app/Components/my_button.dart';
import 'package:minimal_chat_app/Components/my_textfield.dart';
import 'package:minimal_chat_app/Services/auth/auth_service.dart';

class RegisterPage extends StatelessWidget {
  // email and pw text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  // tap to go to Login page
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  // Register method
  void register(BuildContext context) {
    //get auth service
    final _auth = AuthService();

    //passwords match => create user
    if (_pwController.text == _confirmPwController.text) {
      try {
        _auth.signUpWithEmailPassword(
          _emailController.text,
          _pwController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              e.toString(),
            ),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Passwords don't match!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Logo
              Icon(
                Icons.personal_injury,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              // Welcome back message
              Text(
                "Let's create an account for you",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, fontSize: 16),
              ),
              SizedBox(
                height: 25,
              ),

              // email textfield
              MyTextField(
                controller: _emailController,
                hintText: "Email",
                obscureText: false,
              ),
              SizedBox(
                height: 10,
              ),

              // pw textfield
              MyTextField(
                controller: _pwController,
                hintText: "Password",
                obscureText: true,
              ),
              SizedBox(
                height: 10,
              ),

              // Confirm Pw textfield
              MyTextField(
                controller: _confirmPwController,
                hintText: "Confirm Password",
                obscureText: true,
              ),

              SizedBox(
                height: 25,
              ),

              // login button
              MyButton(
                text: "Register",
                onTap: () => register(context),
              ),
              SizedBox(
                height: 25,
              ),

              // register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      " Login now",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
