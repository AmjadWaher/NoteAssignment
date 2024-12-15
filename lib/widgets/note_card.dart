import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/pages/add_note.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
  });
  final Note note;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.only(bottom: mq.width * 0.045),
      color: note.color,
      child: ListTile(
        splashColor: Colors.transparent,
        contentPadding: EdgeInsets.all(mq.width * 0.05),
        title: Padding(
          padding: EdgeInsets.all(mq.width * 0.02),
          child: Center(
            child: Text(
              note.title,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: mq.width * 0.06,
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddNote(
                note: note,
              ),
            ),
          );
        },
      ),
    );
  }
}
