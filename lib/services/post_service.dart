import 'dart:convert';
import 'package:flutter_application/models/post.dart';
import 'package:http/http.dart' as http;

class PostService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<List<Post>> getPosts() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/posts'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);

      return jsonData
          .map((jsonItem) => Post.fromJson(jsonItem))
          .take(20)
          .toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  static Future<Post> getPostById(String id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/posts/$id'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': post.title, 'body': post.body, 'userId': 1}),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create post');
    }
  }

  static Future<Post> updatePost(Post post) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/posts/${post.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': post.title, 'body': post.body}),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update post');
    }
  }

  static Future<void> deletePost(String id) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/posts/$id'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete post');
    }
  }
}
