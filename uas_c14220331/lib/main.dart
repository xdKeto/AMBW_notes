import 'package:flutter/material.dart';
import 'package:uas_c14220331/pages/home_page.dart';
import 'package:uas_c14220331/pages/settings_page.dart';
import 'package:uas_c14220331/theme/app_theme.dart';
import 'package:uas_c14220331/theme/theme_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

final themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    themeManager.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    themeManager.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UAS: Notes App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeManager.themeMode,
      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/settings': (context) => const SettingsPage(),
      }
    );
  }
}
