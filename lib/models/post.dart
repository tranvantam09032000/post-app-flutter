class Post {
  final String id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }
}
