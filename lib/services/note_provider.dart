import 'package:flutter/cupertino.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/services/note_database.dart';

class NoteData with ChangeNotifier {
  List<Note> notes = [];

  void getNotes() {
    NoteDatabase.db.getAllNotes().then((value) {
      notes = value;
      notifyListeners();
    });
  }

  void addToNotes(String title, String content) {
    NoteDatabase.db.addToDatabase(Note(title: title, content: content));
    getNotes();
  }

  void removeFromNotes(int id) {
    NoteDatabase.db.removeFromDatabase(id);
    getNotes();
  }

  void updateNote({int id, String newTitle, String newContent}) {
    NoteDatabase.db.updateNote(Note(title: newTitle, content: newContent, id: id));
    getNotes();
  }
}
