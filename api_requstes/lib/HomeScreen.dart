import 'package:api_requstes/add_post.dart';
import 'package:api_requstes/api_services.dart';
import 'package:api_requstes/edit_post.dart';
import 'package:flutter/material.dart';

import 'note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<HomeScreen> {
  late Future<List<Note>> _notes;
  final ApiServices _apiServices = ApiServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notes = _apiServices.fetchNote();
  }

  void _deleteNotes(String id) async {
    await _apiServices.deleteNote(id);
    setState(() {
      _notes = _apiServices.fetchNote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddPost()),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          "Home Screen",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder(
        future: _notes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("Erro ${snapshot.error}");
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No notes found"));
          }
          final notes = snapshot.data!;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.author),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => EditPost(note: note)),
                  );
                },
                trailing: IconButton(
                    onPressed: () => _deleteNotes(note.id),
                    icon: Icon(Icons.delete)),
              );
            },
          );
        },
      ),
    );
  }
}
