import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../notes/note_model.dart';
import '../notes/note_service.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final NoteService _noteService = NoteService();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void _showAddNoteDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add New Note"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: "Content"),
              maxLines: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final newNote = Note(
                id: const Uuid().v4(),
                title: _titleController.text,
                content: _contentController.text,
                createdAt: DateTime.now(),
              );
              _noteService.addNote(newNote);
              _titleController.clear();
              _contentController.clear();
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(String noteId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Note?"),
        content: const Text("Are you sure you want to delete this note?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("No")),
          ElevatedButton(
            onPressed: () {
              _noteService.deleteNote(noteId);
              Navigator.pop(context);
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📝 Notes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddNoteDialog,
          )
        ],
      ),
      body: StreamBuilder<List<Note>>(
        stream: _noteService.getNotes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final notes = snapshot.data!;
          if (notes.isEmpty) return const Center(child: Text("No notes added yet."));

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (_, index) {
              final note = notes[index];
              return Card(
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(note.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(note.content),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _confirmDelete(note.id),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
