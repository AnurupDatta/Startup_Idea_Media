import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'idea_model.dart';
import 'submission_page.dart';
import 'idea_information.dart';

class MainIdeaScreen extends StatelessWidget {
  final List<Idea> ideas;
  final void Function(int) onUpvote;
  final void Function(Idea) onAddIdea;

  const MainIdeaScreen({
    super.key,
    required this.ideas,
    required this.onUpvote,
    required this.onAddIdea,
  });

  void _shareIdea(BuildContext context, Idea idea) {
    final text =
        'Check out this startup idea!\nTitle: ${idea.title}\nTagline: ${idea.tagline}\nDescription: ${idea.description}';
    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Ideas'),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.lightbulb, color: Colors.deepPurple, size: 32),
                const SizedBox(width: 12),
                Text(
                  'Total Ideas: ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.deepPurple.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${ideas.length}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child:
                ideas.isEmpty
                    ? Center(
                      child: Text(
                        'No ideas yet. Tap + to add one!',
                        style: TextStyle(
                          color: Colors.deepPurple.shade300,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                    : ListView.builder(
                      itemCount: ideas.length,
                      itemBuilder: (context, index) {
                        final idea = ideas[index];
                        return Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 20,
                            ),
                            title: Text(
                              idea.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.deepPurple,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(
                                idea.tagline,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => IdeaInformation(idea: idea),
                                ),
                              );
                            },
                            trailing: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.thumb_up,
                                        color: Colors.deepPurple,
                                      ),
                                      onPressed: () => onUpvote(index),
                                    ),
                                    Text(
                                      '${idea.upvotes}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    Text(
                                      ' ${idea.aiRating.toStringAsFixed(1)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.share,
                                        color: Colors.green,
                                      ),
                                      onPressed:
                                          () => _shareIdea(context, idea),
                                      tooltip: 'Share idea',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        onPressed: () async {
          final newIdea = await Navigator.push<Idea>(
            context,
            MaterialPageRoute(builder: (context) => SubmissionPage()),
          );
          if (newIdea != null) {
            onAddIdea(newIdea);
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Idea'),
      ),
    );
  }
}
