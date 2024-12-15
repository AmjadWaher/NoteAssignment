import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';

List<Note> notes = [
  Note(
      title: 'UI concepts worth exsisting',
      content: 'Course',
      color: Colors.white)
];
List<Note> notesSearchList = [];
var streamNoteController = StreamController.broadcast();
