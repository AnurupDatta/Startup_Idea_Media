import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const LeaderboardPage({
    Key? key,
    required this.onThemeToggle,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: onThemeToggle,
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Leaderboard Content',
          style: TextStyle(
            fontSize: 24,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
