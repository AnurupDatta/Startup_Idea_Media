import 'package:flutter/material.dart';
import 'main_idea_screen.dart';
import 'leaderboard.dart';
import 'submission_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'idea_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  final List<Idea> _ideas = [];

  @override
  void initState() {
    super.initState();
    _loadIdeas();
  }

  Future<void> _loadIdeas() async {
    final prefs = await SharedPreferences.getInstance();
    final ideasString = prefs.getString('ideas');
    if (ideasString != null) {
      final List<dynamic> decoded = jsonDecode(ideasString);
      setState(() {
        _ideas.clear();
        _ideas.addAll(decoded.map((e) => Idea.fromJson(e)));
      });
    }
  }

  Future<void> _saveIdeas() async {
    final prefs = await SharedPreferences.getInstance();
    final ideasString = jsonEncode(_ideas.map((e) => e.toJson()).toList());
    await prefs.setString('ideas', ideasString);
  }

  void _addIdea(Idea idea) {
    setState(() {
      _ideas.add(idea);
    });
    _saveIdeas();
  }

  void _upvoteIdea(int index) {
    setState(() {
      _ideas[index].upvotes += 1;
    });
    _saveIdeas();
  }

  List<Widget> get _pages => [
    MainIdeaScreen(ideas: _ideas, onUpvote: _upvoteIdea, onAddIdea: _addIdea),
    Leaderboard(ideas: _ideas, onUpvote: _upvoteIdea),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Idea App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb),
              label: 'Ideas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: 'Leaderboard',
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
