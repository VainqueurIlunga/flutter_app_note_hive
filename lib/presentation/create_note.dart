import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_hive_note/model/note.dart';

class NoteCreatePage extends StatefulWidget {
  @override
  _NoteCreatePageState createState() => _NoteCreatePageState();
}

class _NoteCreatePageState extends State<NoteCreatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  late Box<Note> noteBox;

  @override
  void initState() {
    super.initState();
    noteBox = Hive.box<Note>('notes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
              ),
            ),
            SizedBox(height: 16.0),
            
              
            ElevatedButton(
              onPressed: () {
                final newNote=Note(
                  title: _titleController.text,
                  content: _contentController.text,);
                noteBox.add(newNote);
                Navigator.pop(context);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Note created')),
                  );
                }
              }, 
              child: const Text('note Create'),)
          ],
        ),
      ),
    );
  }
}