import 'package:flutter/material.dart';
import 'package:wallfaper/screens/authentication/forgot_password_screen.dart';
import 'package:wallfaper/screens/authentication/login_screen.dart';
import 'package:wallfaper/screens/authentication/register_screen.dart';
import 'package:wallfaper/screens/common/favorite_screen.dart';
import 'package:wallfaper/screens/common/home_screen.dart';
import 'package:wallfaper/screens/common/notification_screen.dart';
import 'package:wallfaper/screens/common/profile_screen.dart';
import 'package:wallfaper/screens/not_found_screen.dart';
import 'package:wallfaper/screens/splash_screen.dart';
import 'package:wallfaper/screens/wizard/setup_profile_screen.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String setupProfile = '/setup-profile';
  static const String home = '/home';
  static const String notification = '/notification';
  static const String favorite = '/favorite';
  static const String profile = '/profile';
  static const String notFound = '/not-found';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case setupProfile:
        return MaterialPageRoute(builder: (_) => const SetupProfileScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case notification:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case favorite:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundScreen());
    }
  }
}
