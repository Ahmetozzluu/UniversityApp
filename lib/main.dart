import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universtyapp/config/themes/app_theme.dart';
import 'package:universtyapp/features/auth/presentation/pages/login_page.dart';
import 'package:universtyapp/features/favorites/providers/favorites_provider.dart';
import 'package:universtyapp/features/university/providers/review_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Üniversite Uygulaması',
        theme: AppTheme.lightTheme,
        home: const LoginPage(),
      ),
    );
  }
}