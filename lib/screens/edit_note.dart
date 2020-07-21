import 'package:flutter/material.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/services/note_provider.dart';

class EditNote extends StatelessWidget {
  EditNote({this.data, this.note});

  final NoteData data;
  final Note note;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    String title = note.title;
    String content = note.content;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'New Note',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF5b696f),
      ),
      floatingActionButton: Padding(
          padding: EdgeInsets.only(left: 10, bottom: 10),
          child: FloatingActionButton.extended(
            icon: Icon(Icons.add),
            label: Text('UPDATE'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                data.updateNote(
                    id: note.id, newContent: content, newTitle: title);
                Navigator.pop(context);
              }
            },
          )),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    initialValue: note.title,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter some text';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      title = text;
                    },
                    decoration: InputDecoration(
//                        fillColor: Color(0xFFcedae2),
                      labelStyle: TextStyle(color: Colors.black38),
                      border: OutlineInputBorder(),
                      labelText: 'Note Title',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    initialValue: note.content,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter some text';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      content = text;
                    },
                    maxLines: 90,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            )),
      ),
    );
  }
}
