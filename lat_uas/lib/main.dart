import 'package:flutter/material.dart';
import 'package:lat_uas/auth/login_page.dart';
import 'package:lat_uas/home/home_page.dart';
import 'package:lat_uas/orders/order_history_page.dart';
import 'package:lat_uas/profile/profile_page.dart';
import 'package:lat_uas/services/auth_gate.dart';
import 'package:lat_uas/services/supabase_client.dart';
import 'package:lat_uas/theme/app_theme.dart';
import 'package:lat_uas/theme/theme_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SupabaseService.initialize();
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
      title: 'TicketWave Mobile',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeManager.themeMode,
      home: const AuthGate(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/orders': (context) => const OrderHistoryPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
