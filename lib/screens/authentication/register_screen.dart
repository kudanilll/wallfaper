import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallfaper/routes.dart';
import 'package:wallfaper/services/auth_service.dart';
import 'package:wallfaper/widgets/button.dart';
import 'package:wallfaper/widgets/header.dart';
import 'package:wallfaper/widgets/snackbar.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

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

  bool validate(BuildContext context) {
    if (_userNameController.text.isEmpty) {
      Snackbar(
        context: context,
        text: 'Username cannot be empty',
        isError: true,
      ).show();
      return false;
    }
    if (_userNameController.text.contains(' ')) {
      Snackbar(
        context: context,
        text: 'Username cannot contain spaces',
        isError: true,
      ).show();
      return false;
    }
    if (_emailController.text.isEmpty) {
      Snackbar(
        context: context,
        text: 'Email cannot be empty',
        isError: true,
      ).show();
      return false;
    }
    if (!_emailController.text.isValidEmail()) {
      return false;
    }
    if (_passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      Snackbar(
        context: context,
        text: 'Password cannot be empty',
        isError: true,
      ).show();
      return false;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      Snackbar(
        context: context,
        text: 'Passwords are not the same',
        isError: true,
      ).show();
      return false;
    }
    if (_passwordController.text.length < 6) {
      Snackbar(
        context: context,
        text: 'Password must be at least 6 characters',
        isError: true,
      ).show();
      return false;
    }
    return true;
  }

  Future<void> _onSubmit(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!validate(context)) return;
    bool usernameAvailable =
        await AuthService().isUsernameAvailable(_userNameController.text);
    if (context.mounted) {
      if (!usernameAvailable) {
        Snackbar(
          context: context,
          text: 'Username not available',
          isError: true,
        ).show();
        return;
      }
    }
    User? user = await AuthService().registerWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
        _userNameController.text);
    if (context.mounted) {
      if (user == null) {
        Snackbar(
          context: context,
          text: 'Register failed',
          isError: true,
        ).show();
      } else {
        Snackbar(context: context, text: 'Register success').show();
        Navigator.pushReplacementNamed(context, Routes.setupProfile);
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
