import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../flashcards/flashcard_model.dart';
import '../flashcards/flashcard_service.dart';
import '../services/flashcard_service.dart'; // This should call your Ollama API

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final FlashcardService _flashcardService = FlashcardService();
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();
  final _notesController = TextEditingController();

  bool _showAnswer = false;
  List<Map<String, String>> _autoFlashcards = [];

  void _addFlashcard() async {
    if (_questionController.text.isEmpty || _answerController.text.isEmpty) return;

    final flashcard = Flashcard(
      id: const Uuid().v4(),
      question: _questionController.text.trim(),
      answer: _answerController.text.trim(),
      createdAt: Timestamp.now(),
    );

    await _flashcardService.addFlashcard(flashcard);
    _questionController.clear();
    _answerController.clear();
    Navigator.pop(context);
  }

  void _generateFlashcardsFromNotes() async {
    if (_notesController.text.isEmpty) return;

    try {
      final generated = await generateFlashcards(_notesController.text.trim());
      setState(() {
        _autoFlashcards = generated;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error generating flashcards: $e")),
      );
    }
  }

  void _showAddFlashcardDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Flashcard"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(labelText: "Question"),
            ),
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(labelText: "Answer"),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(onPressed: _addFlashcard, child: const Text("Save")),
        ],
      ),
    );
  }

  void _showAutoFlashcardDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Generate Flashcards"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _notesController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Paste your study notes",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _generateFlashcardsFromNotes();
            },
            child: const Text("Generate"),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashcard(Flashcard flashcard) {
    return GestureDetector(
      onTap: () => setState(() => _showAnswer = !_showAnswer),
      onLongPress: () async {
        await _flashcardService.deleteFlashcard(flashcard.id);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.deepPurple[50],
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black12)],
        ),
        child: Center(
          child: Text(
            _showAnswer ? flashcard.answer : flashcard.question,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flashcards")),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: _showAddFlashcardDialog,
            child: const Icon(Icons.add),
            tooltip: "Add Flashcard Manually",
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: _showAutoFlashcardDialog,
            child: const Icon(Icons.auto_awesome),
            tooltip: "Generate from Notes",
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Flashcard>>(
              stream: _flashcardService.getFlashcards(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final flashcards = snapshot.data!;
                if (flashcards.isEmpty) {
                  return const Center(child: Text("No flashcards yet."));
                }

                return PageView.builder(
                  itemCount: flashcards.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: _buildFlashcard(flashcards[index]),
                    );
                  },
                );
              },
            ),
          ),
          if (_autoFlashcards.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: _autoFlashcards.map((card) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(card['question'] ?? ''),
                      subtitle: Text(card['answer'] ?? ''),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
