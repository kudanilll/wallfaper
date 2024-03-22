import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallfaper/routes.dart';
import 'package:wallfaper/services/auth_service.dart';
import 'package:wallfaper/widgets/button.dart';
import 'package:wallfaper/widgets/google_auth_button.dart';
import 'package:wallfaper/widgets/header.dart';
import 'package:wallfaper/widgets/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hidePassword = false;

  Future<void> _onSubmit(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    User? user = await AuthService().signInWithEmailAndPassword(
        _emailController.text, _passwordController.text);
    if (context.mounted) {
      if (user == null) {
        Snackbar(context: context, text: 'Login failed', isError: true).show();
      } else {
        Navigator.pushReplacementNamed(context, Routes.home);
      }
    }
  }

  Future<void> _loginWithGoogle() async {
    try {
      UserCredential userCredential = await AuthService().signInWithGoogle();
      User? user = userCredential.user;
      if (user != null) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, Routes.home);
        }
      }
    } catch (e) {
      if (mounted) {
        Snackbar(
                context: context,
                text: 'Error signing in with Google',
                isError: true)
            .show();
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
              title: 'Welcome Back',
              subtitle: 'Enter your Email address to sign in.',
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 36, 0, 6),
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
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 30),
            //   child: GestureDetector(
            //     onTap: () => Navigator.pushNamed(context, Routes.forgotPassword),
            //     child: Align(
            //       alignment: Alignment.centerLeft,
            //       child: SizedBox(
            //         child: Text(
            //           'Forgot Password?',
            //           style: TextStyle(color: Colors.green.shade700),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Button(
                width: double.infinity,
                onTap: () => _onSubmit(context),
                text: 'SIGN IN',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, Routes.register),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account? '),
                    Text(
                      'Create an account',
                      style: TextStyle(
                        color: Colors.green.shade700,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'OR',
                style: TextStyle(fontSize: 16),
              ),
            ),
            GoogleAuthButton(
              onTap: () => _loginWithGoogle(),
            ),
          ],
        ),
      ),
    );
  }
}
