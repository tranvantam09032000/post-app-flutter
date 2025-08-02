import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post.dart';
import '../providers/post_provider.dart';

class PostFormScreen extends StatefulWidget {
  final Post? post;

  PostFormScreen({this.post});

  @override
  _PostFormScreenState createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      _titleController.text = widget.post!.title;
      _contentController.text = widget.post!.body;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _savePost() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final content = _contentController.text.trim();

      if (title.isEmpty || content.isEmpty) return;

      final postProvider = Provider.of<PostProvider>(context, listen: false);

      if (widget.post == null) {
        final newPost = Post(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          body: content,
        );
        postProvider.addPost(newPost);
      } else {
        final updatedPost = Post(
          id: widget.post!.id,
          title: title,
          body: content,
        );
        postProvider.updatePost(updatedPost);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.post != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Sửa bài viết' : 'Tạo bài viết')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Tiêu đề'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tiêu đề không được để trống';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Nội dung'),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nội dung không được để trống';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePost,
                child: Text(isEditing ? 'Cập nhật' : 'Tạo mới'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
