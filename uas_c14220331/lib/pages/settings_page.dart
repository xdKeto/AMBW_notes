import 'package:flutter/material.dart';
import 'package:uas_c14220331/main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListenableBuilder(
        listenable: themeManager,
        builder: (context, child) {
          return Column(
            children: [
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text('Dark Mode'),
                trailing: Switch(
                  value: themeManager.isDarkMode,
                  onChanged: (value) {
                    themeManager.toggleTheme(value);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
