

import 'package:flutter/material.dart';
import 'api_services.dart';
import 'note.dart';
import 'HomeScreen.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final ApiServices _apiServices = ApiServices();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _pagesController = TextEditingController();
  final TextEditingController _genresController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();

  void _addNote() async {
    final Note newNote = Note(
      id: '',
      title: _titleController.text,
      author: _authorController.text,
      pages: int.parse(_pagesController.text),
      genres: _genresController.text.split(','),
      rating: int.parse(_ratingController.text),
    );

    try {
      await _apiServices.createNote(newNote);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Post',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _authorController,
                decoration: InputDecoration(
                  hintText: 'Author',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _pagesController,
                decoration: InputDecoration(
                  hintText: 'Pages',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _genresController,
                decoration: InputDecoration(
                  hintText: 'Genres (comma-separated)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _ratingController,
                decoration: InputDecoration(
                  hintText: 'Rating',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 30),
              MaterialButton(
                onPressed: _addNote,
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    'Add Post',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

