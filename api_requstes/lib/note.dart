
class Note {
  final String id;
  final String title;
  final String author;
  final int pages;
  final List<String> genres;
  final int rating;

  Note({
    required this.id,
    required this.title,
    required this.author,
    required this.pages,
    required this.genres,
    required this.rating,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      pages: json['pages'] ?? 0,
      genres: List<String>.from(json['genres'] ?? []),
      rating: json['rating'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'pages': pages,
      'genres': genres,
      'rating': rating,
    };
  }
}
