import 'package:flutter/material.dart';

class IdeaPage extends StatelessWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const IdeaPage({
    Key? key,
    required this.onThemeToggle,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Idea Page'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: onThemeToggle,
          ),
        ],
      ),
      body: Center(
        child: Text(
          'This is the Idea Page',
          style: TextStyle(
            fontSize: 24,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
