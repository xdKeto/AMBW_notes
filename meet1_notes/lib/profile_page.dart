
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // Background
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: LinearGradient(
                      colors: [Colors.teal.shade800, Colors.teal.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                // Profile picture
                Positioned(
                  top: 50,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg'),
                  ),
                ),
                // Profile details
                Positioned(
                  top: 160,
                  child: Column(
                    children: [
                      const Text(
                        'John Doe',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Flutter Developer',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
