import 'package:cloud_firestore/cloud_firestore.dart';
import 'flashcard_model.dart';

class FlashcardService {
  final _flashcardCollection = FirebaseFirestore.instance.collection('flashcards');

  Future<void> addFlashcard(Flashcard flashcard) async {
    await _flashcardCollection.doc(flashcard.id).set(flashcard.toJson());
  }

  Stream<List<Flashcard>> getFlashcards() {
    return _flashcardCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Flashcard.fromJson(doc.data())).toList());
  }

  Future<void> deleteFlashcard(String id) async {
    await _flashcardCollection.doc(id).delete();
  }
}
