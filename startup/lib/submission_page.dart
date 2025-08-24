import 'package:flutter/material.dart';
import 'idea_model.dart';
import 'dart:math';

class SubmissionPage extends StatefulWidget {
  const SubmissionPage({super.key});

  @override
  State<SubmissionPage> createState() => _SubmissionPageState();
}

class _SubmissionPageState extends State<SubmissionPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _tagline = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0F172A),
                    Color(0xFF1E293B),
                  ],
                )
              : const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
                ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode 
                    ? const Color(0xFF1E293B)
                    : Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.lightbulb,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Share your Startup Idea!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: isDarkMode
                              ? const Color(0xFFF8FAFC)
                              : const Color(0xFF1F2937),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Inspire others with your innovative concept',
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkMode
                              ? Colors.grey.shade300
                              : Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Title',
                          hintText: 'Enter your idea title',
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6366F1).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.title,
                              color: Color(0xFF6366F1),
                            ),
                          ),
                          labelStyle: const TextStyle(
                            color: Color(0xFF6366F1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onSaved: (val) => _title = val ?? '',
                        validator:
                            (val) =>
                                val == null || val.isEmpty
                                    ? 'Title is required'
                                    : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Tagline',
                          hintText: 'Brief description of your idea',
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B5CF6).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.short_text,
                              color: Color(0xFF8B5CF6),
                            ),
                          ),
                          labelStyle: const TextStyle(
                            color: Color(0xFF8B5CF6),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onSaved: (val) => _tagline = val ?? '',
                        validator:
                            (val) =>
                                val == null || val.isEmpty
                                    ? 'Tagline is required'
                                    : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Detailed explanation of your startup idea',
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFA855F7).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.description,
                              color: Color(0xFFA855F7),
                            ),
                          ),
                          labelStyle: const TextStyle(
                            color: Color(0xFFA855F7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onSaved: (val) => _description = val ?? '',
                        validator:
                            (val) =>
                                val == null || val.isEmpty
                                    ? 'Description is required'
                                    : null,
                        maxLines: 4,
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6366F1),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 8,
                            shadowColor: const Color(
                              0xFF6366F1,
                            ).withOpacity(0.4),
                          ),
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 24,
                          ),
                          label: const Text(
                            'Submit Idea',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              final aiRating =
                                  3.0 + Random().nextDouble() * 2.0;
                              final idea = Idea(
                                title: _title,
                                tagline: _tagline,
                                description: _description,
                                aiRating: aiRating,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Idea submitted!'),
                                  duration: Duration(milliseconds: 1200),
                                ),
                              );
                              Navigator.pop(context, idea);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
