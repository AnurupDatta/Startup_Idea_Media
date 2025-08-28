import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/main_idea_screen.dart';
import '../screens/leaderboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/idea_model.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;
  final String userEmail; // <-- Add this line

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
    this.userEmail = '', // <-- Add default value for backward compatibility
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Idea> _ideas = [];

  // Placeholder user info; replace with actual user data as needed
  final String _userName = "John Doe";
  // Remove the placeholder email
  // final String _userEmail = "john.doe@example.com";

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
    MainIdeaScreen(
      ideas: _ideas,
      onUpvote: _upvoteIdea,
      onAddIdea: _addIdea,
      isDarkMode: widget.isDarkMode,
    ),
    Leaderboard(
      ideas: _ideas,
      onUpvote: _upvoteIdea,
      isDarkMode: widget.isDarkMode,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(_userName),
                accountEmail: Text(
                  widget.userEmail.isNotEmpty ? widget.userEmail : "No email",
                ),
                currentAccountPicture: CircleAvatar(
                  child: Text(
                    _userName.isNotEmpty ? _userName[0] : '',
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF6366F1),
                      Color(0xFF8B5CF6),
                      Color(0xFFA855F7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              // Replace Spacer() with SizedBox for upward spacing
              const SizedBox(height: 40),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log Out'),
                onTap: () async {
                  final shouldLogout = await showDialog<bool>(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: const Text('Confirm Logout'),
                          content: const Text(
                            'Are you sure you want to log out?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6366F1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text(
                                'Log Out',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                  );
                  if (shouldLogout == true) {
                    Navigator.of(context).pop(); // Close the drawer
                    await FirebaseAuth.instance.signOut();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient:
              widget.isDarkMode
                  ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF0F172A),
                      Color(0xFF1E293B),
                      Color(0xFF334155),
                    ],
                  )
                  : const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFF8FAFC),
                      Color(0xFFF1F5F9),
                      Color(0xFFE2E8F0),
                    ],
                  ),
        ),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: widget.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFF6366F1),
          unselectedItemColor:
              widget.isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb_outline),
              activeIcon: Icon(Icons.lightbulb),
              label: 'Ideas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard_outlined),
              activeIcon: Icon(Icons.leaderboard),
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
      appBar: AppBar(
        title: const Text('Startup Ideas'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFFA855F7)],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
            onPressed: widget.onThemeToggle,
            tooltip:
                widget.isDarkMode
                    ? 'Switch to Light Mode'
                    : 'Switch to Dark Mode',
          ),
        ],
      ),
    );
  }
}
