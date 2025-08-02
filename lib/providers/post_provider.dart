import 'package:flutter/material.dart';
import 'package:flutter_application/models/post.dart';
import 'package:flutter_application/services/post_service.dart';

class PostProvider extends ChangeNotifier {
  List<Post> _posts = [];
  bool _isLoading = false;
  late Post _post;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _posts = await PostService.getPosts();
    } catch (e) {
      _posts = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPost(String id) async {
    _post = await PostService.getPostById(id);
    notifyListeners();
  }

  Future<void> addPost(Post post) async {
    final newPost = await PostService.createPost(post);
    _posts.insert(0, newPost);
    notifyListeners();
  }

  Future<void> updatePost(Post post) async {
    final updatedPost = await PostService.updatePost(post);
    final index = _posts.indexWhere((p) => p.id == post.id);
    if (index != -1) {
      _posts[index] = updatedPost;
      notifyListeners();
    }
  }

  Future<void> deletePost(String id) async {
    await PostService.deletePost(id);
    _posts.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
