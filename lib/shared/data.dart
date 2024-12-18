import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';

final titleController = TextEditingController();
final contentController = TextEditingController();
final random = Random();

Color randomColor() {
  return Color.fromARGB(
    255,
    random.nextInt(255),
    random.nextInt(255),
    random.nextInt(255),
  );
}

List<Note> notes = [];

List<Note> notesSearchList = [];
var streamNoteController = StreamController.broadcast();
