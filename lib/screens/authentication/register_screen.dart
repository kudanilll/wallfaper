import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallfaper/routes.dart';
import 'package:wallfaper/services/auth_service.dart';
import 'package:wallfaper/widgets/button.dart';
import 'package:wallfaper/widgets/header.dart';
import 'package:wallfaper/widgets/snackbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _hidePassword = false;

  Future<void> _onSubmit(BuildContext context) async {
    if (_emailController.text != _confirmPasswordController.text) {
      Snackbar(
              context: context,
              text: 'Passwords are not the same',
              isError: true)
          .show();
      return;
    }
    User? user = await AuthService().registerWithEmailAndPassword(
        _emailController.text, _passwordController.text);
    if (context.mounted) {
      if (user == null) {
        Snackbar(context: context, text: 'Register failed', isError: true)
            .show();
      } else {
        // Snackbar(context: context, text: '').show();
        Navigator.pushNamed(context, Routes.home);
      }
    }
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Header(
              title: 'Create Account',
              subtitle: 'Fill in the form below to create an account.',
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 36, 0, 6),
              child: SizedBox(
                key: const Key('UserNameField'),
                child: TextField(
                  controller: _userNameController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
              child: SizedBox(
                key: const Key('EmailField'),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
              child: SizedBox(
                key: const Key('PasswordField'),
                child: TextField(
                  controller: _passwordController,
                  obscureText: _hidePassword,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(_hidePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 6, 0, 30),
              child: SizedBox(
                key: const Key('ConfirmPasswordField'),
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: _hidePassword,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(_hidePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'Confirm Password',
                  ),
                ),
              ),
            ),
            Button(
              width: double.infinity,
              onTap: () => _onSubmit(context),
              text: 'REGISTER',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, Routes.login),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? '),
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.green.shade700,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
