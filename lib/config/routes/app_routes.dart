import 'package:flutter/material.dart';
import 'package:universtyapp/features/auth/presentation/pages/login_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> get routes {
    return {
      login: (context) => const LoginPage(),
      // Diğer sayfalar eklendikçe buraya eklenecek
    };
  }
} 