import 'dart:io';

import 'package:notes/models/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class NoteDatabase {
  NoteDatabase._();

  static final NoteDatabase db = NoteDatabase._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'notes.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE notes(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      content TEXT)''');
    });
  }

  Future<int> addToDatabase(Note note) async {
    final db = await database;
    var a = db.insert('notes', note.toMap());
    return a;
  }

  Future<int> removeFromDatabase(int id) async {
    final db = await database;
    var a = db.delete('notes', where: 'id = ?', whereArgs: [id]);
    return a;
  }

  Future<Note> getNoteById(int id) async {
    final db = await database;
    var response = await db.query('notes', where: 'id = ?', whereArgs: [id]);
    return response.isNotEmpty ? Note.fromMap(response.first) : null;
  }

  Future<List<Note>> getAllNotes() async {
    final db = await database;
    var response = await db.query('notes');
    List<Note> list = response.isNotEmpty
        ? response.map((e) => Note.fromMap(e)).toList()
        : [];
    return list;
  }

  Future<int> updateNote(Note note) async {
    final db = await database;
    var response =
        db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
    return response;
  }
}
