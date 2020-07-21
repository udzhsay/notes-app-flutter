import 'package:flutter/material.dart';
import 'package:notes/screens/notes_screen.dart';
import 'package:notes/services/note_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        NoteData noteData = NoteData();
        noteData.getNotes();
        return noteData;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          backgroundColor: Color(0xFFf0f5f9),
          cardColor: Color(0xFFc9d6df),
          primaryColor: Color(0xFFc9d6df),
          accentColor: Color(0xFF52616b),
        ),
        home: NotesScreen(),
      ),
    );
  }
}
