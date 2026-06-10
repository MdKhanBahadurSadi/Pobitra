class ReaderContent {
  final String title;
  final String? author;
  final String? coverImage;
  final String body;

  ReaderContent({
    required this.title,
    this.author,
    this.coverImage,
    required this.body,
  });

  factory ReaderContent.fromJson(Map<String, dynamic> json) {
    return ReaderContent(
      title: json['title'] ?? 'No Title',
      author: json['author'],
      coverImage: json['coverImage'],
      body: json['body'] ?? '',
    );
  }
}
