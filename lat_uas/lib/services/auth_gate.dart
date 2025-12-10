import 'package:flutter/material.dart';
import 'package:lat_uas/auth/login_page.dart';
import 'package:lat_uas/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final session = snapshot.hasData ? snapshot.data!.session : null;

        if (session != null) {
          // Persist email if session exists (bonus requirement support)
          _persistSession(session.user.email);
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }

  Future<void> _persistSession(String? email) async {
    if (email == null) return;
    final prefs = await SharedPreferences.getInstance();
    // Only save if not already saved or different, to avoid spamming writes
    if (prefs.getString('saved_email') != email) {
      await prefs.setString('saved_email', email);
    }
  }
}
