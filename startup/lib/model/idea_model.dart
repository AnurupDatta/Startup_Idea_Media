class Idea {
  String title;
  String tagline;
  String description;
  int upvotes;
  double aiRating;

  Idea({
    required this.title,
    required this.tagline,
    required this.description,
    this.upvotes = 0,
    required this.aiRating,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'tagline': tagline,
    'description': description,
    'upvotes': upvotes,
    'aiRating': aiRating,
  };

  factory Idea.fromJson(Map<String, dynamic> json) => Idea(
    title: json['title'],
    tagline: json['tagline'],
    description: json['description'],
    upvotes: json['upvotes'],
    aiRating: (json['aiRating'] as num).toDouble(),
  );
}
