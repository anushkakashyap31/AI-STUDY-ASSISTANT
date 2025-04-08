import 'package:cloud_firestore/cloud_firestore.dart';
import 'note_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoteService {
  final _notesCollection = FirebaseFirestore.instance.collection('notes');

  String _userId() => FirebaseAuth.instance.currentUser!.uid;

  Future<void> addNote(Note note) async {
    await _notesCollection
        .doc(_userId())
        .collection('user_notes')
        .doc(note.id)
        .set(note.toJson());
  }

  Stream<List<Note>> getNotes() {
    return _notesCollection
        .doc(_userId())
        .collection('user_notes')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Note.fromJson(doc.data()))
            .toList());
  }

  Future<void> deleteNote(String noteId) async {
    await _notesCollection
        .doc(_userId())
        .collection('user_notes')
        .doc(noteId)
        .delete();
  }
}
