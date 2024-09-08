import 'package:flutter/material.dart';

import 'HomeScreen.dart';
import 'api_services.dart';
import 'note.dart';

class EditPost extends StatefulWidget {
  final Note? note;
  const EditPost({super.key, this.note});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  late Future<List<Note>> _notes;
  final ApiServices _apiServices = ApiServices();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _pagesController = TextEditingController();
  final TextEditingController _genresController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _authorController.text = widget.note!.author;
      _pagesController.text = widget.note!.pages.toString();
      _genresController.text = widget.note!.genres.join(',');
      _ratingController.text = widget.note!.rating.toString();
    }
  }

  void _updateNote(Note note) async {
    await _apiServices.updateNote(note.id, note);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Post',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.yellow,
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
                onPressed: () {
                  _updateNote(
                    Note(
                        id: widget.note!.id,
                        title: _titleController.text,
                        author: _authorController.text,
                        pages: int.parse(_pagesController.text),
                        genres: _genresController.text
                            .split(',')
                            .map((e) => e.trim())
                            .toList(),
                        rating: int.parse(_ratingController.text)),
                  );
                },
                color: Colors.yellow,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    'Edit Post',
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
