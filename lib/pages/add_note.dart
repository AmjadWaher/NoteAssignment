import 'package:flutter/material.dart';
import 'package:notes_app/controller/note.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/shared/data.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key, this.note});
  final Note? note;

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  void initialNote() {
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
    }
  }

  @override
  void initState() {
    super.initState();
    initialNote();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actionsPadding: EdgeInsets.only(right: mq.width * 0.037),
        actions: [
          SizedBox(width: mq.width * 0.025),
          IconButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                titleController.clear();
                contentController.clear();
              }
              Navigator.of(context).pop();
            },
            style: IconButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 59, 59, 59),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(mq.width * 0.037),
              ),
            ),
            icon: Icon(Icons.arrow_back),
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              if (titleController.text.isEmpty ||
                  contentController.text.isEmpty) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  showSnackBar(
                    context: context,
                    content: titleController.text.isEmpty
                        ? 'Title must be entered.'
                        : 'Content must be entered.',
                  ),
                );
                return;
              }

              if (widget.note != null) {
                updateNote(widget.note!);
              } else {
                saveNote();
              }
              Navigator.of(context).pop();
            },
            style: IconButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 59, 59, 59),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(mq.width * 0.037),
              ),
            ),
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(mq.width * 0.03),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              cursorColor: Color.fromARGB(255, 255, 255, 255),
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: mq.width * 0.085,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 154, 154, 154),
                  fontSize: mq.width * 0.12,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
              ),
              maxLines: null,
            ),
            SizedBox(
              height: 37,
            ),
            TextField(
              controller: contentController,
              cursorColor: Color.fromARGB(255, 255, 255, 255),
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: mq.width * 0.058,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: 'Type something...',
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 154, 154, 154),
                  fontSize: mq.width * 0.058,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
              ),
              maxLines: null,
            ),
          ],
        ),
      ),
    );
  }
}
