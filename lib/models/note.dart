import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Note {
  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.color,
  });

  String id;
  String title;
  String content;
  Color color;

  factory Note.fromMap(Map<String, dynamic> data) {
    return Note(
      id: data['id'],
      title: data['title'],
      content: data['content'],
      color: Color.fromARGB(
        data['Alpha'],
        data['Red'],
        data['Green'],
        data['Blue'],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['Alpha'] = (color.a * 255).toInt();
    data['Red'] = (color.r * 255).toInt();
    data['Green'] = (color.g * 255).toInt();
    data['Blue'] = (color.b * 255).toInt();

    return data;
  }
}
