import 'package:flutter/material.dart';
import 'package:notes/screens/edit_note.dart';
import 'package:notes/screens/view_note.dart';
import 'package:notes/services/note_provider.dart';
import 'package:provider/provider.dart';

import '../widgets.dart';
import 'new_note.dart';

class NotesScreen extends StatelessWidget {
  final Color black = Color(0xFF1e2022);

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (BuildContext context, noteData, Widget child) {
        return Scaffold(
          floatingActionButton: Padding(
              padding: EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return NewNote(
                      data: noteData,
                    );
                  }));
                },
                child: Icon(Icons.add),
              )),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Color(0xFF49565e),
                title: Text(
                  'Your Notes',
                  style: TextStyle(color: Colors.white),
                ),
                expandedHeight: 250,
                floating: false,
                pinned: true,
                flexibleSpace: Container(),
              ),
              SliverPadding(padding: EdgeInsets.all(10)),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  final note = noteData.notes[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return EditNote(
                          data: noteData,
                          note: note,
                        );
                      }));
                    },
                    onLongPress: () {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            title: Text(
                              'Delete?',
                              style: TextStyle(color: Color(0xFF49565e)),
                            ),
                            actions: [
                              FlatButton(
                                  child: Text(
                                    'YES',
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  onPressed: () {
                                    noteData.removeFromNotes(note.id);
                                    Navigator.pop(context);
                                  }),
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'CANCEL',
                                    style: TextStyle(color: Color(0xFF49565e)),
                                  ))
                            ],
                          ));
                      //                      noteData.removeFromNotes(note.id);
                    },
                    child: NoteCard(
                      title: note.title,
                      content: note.content,
                    ),
                  );
                }, childCount: noteData.notes.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
              ),
            ],
          ),
        );
      },
    );
  }
}
