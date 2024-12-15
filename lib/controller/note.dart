import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/shared/data.dart';

final titleController = TextEditingController();
final contentController = TextEditingController();
final random = Random();
final color = Color.fromARGB(
  255,
  random.nextInt(256),
  random.nextInt(256),
  random.nextInt(256),
);

void saveNote() {
  notes.add(
    Note(
      title: titleController.text,
      content: contentController.text,
      color: color,
    ),
  );

  streamNoteController.sink.add(notes);
  titleController.clear();
  contentController.clear();
}

void updateNote(Note note) {
  note.title = titleController.text;
  note.content = contentController.text;
}

SnackBar showSnackBar({
  required BuildContext context,
  required String content,
}) {
  final mq = MediaQuery.of(context).size;
  return SnackBar(
    content: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(mq.width * 0.01)),
      child: Padding(
        padding: EdgeInsets.all(mq.width * 0.02),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              size: mq.width * 0.09,
              color: Colors.white,
            ),
            SizedBox(width: mq.width * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Error Occurred',
                  style: TextStyle(
                    fontSize: mq.width * 0.05,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: mq.width * 0.02,
                ),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: mq.width * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}