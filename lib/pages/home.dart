import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notes_app/controller/home.dart';
import 'package:notes_app/pages/add_note.dart';
import 'package:notes_app/shared/data.dart';
import 'package:notes_app/widgets/note_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: isSearch
            ? TextField(
                cursorColor: Colors.white,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: mq.width * 0.04,
                ),
                onChanged: (value) {
                  notesSearchList = searchInNotes(value);

                  setState(() {
                    notesSearchList;
                  });
                },
              )
            : Text(
                'Notes',
                style: TextStyle(
                  fontSize: mq.width * 0.1,
                  fontWeight: FontWeight.w600,
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearch = !isSearch;
              });
            },
            style: IconButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 59, 59, 59),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(mq.width * 0.037),
              ),
            ),
            icon: Icon(isSearch ? Icons.search_off : Icons.search),
          ),
          SizedBox(width: mq.width * 0.03),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddNote(),
            ),
          );
        },
        backgroundColor: Color.fromARGB(100, 37, 37, 37),
        shape: CircleBorder(),
        foregroundColor: Colors.white,
        elevation: 2,
        highlightElevation: 2,
        splashColor: Colors.transparent,
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
      body: notesSearchList.isNotEmpty || isSearch
          ? Padding(
              padding: EdgeInsets.all(
                mq.width * 0.045,
              ),
              child: ListView.builder(
                itemCount: notesSearchList.length,
                itemBuilder: (context, index) {
                  return NoteCard(
                    note: notesSearchList[index],
                  );
                },
              ),
            )
          : StreamBuilder(
              stream: streamNoteController.stream,
              builder: (context, snapshot) {
                return notes.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage('assets/images/note.jpg')),
                          Text(
                            'Create your first note !',
                            style: TextStyle(
                              color: Color.fromARGB(100, 255, 255, 255),
                              fontSize: 17,
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: EdgeInsets.all(
                          mq.width * 0.045,
                        ),
                        child: ListView.builder(
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(notes[index].id),
                              onDismissed: (direction) {
                                removeNote(context, notes[index]);
                                log('${notes.length}');
                              },
                              background: Padding(
                                padding:
                                    EdgeInsets.only(bottom: mq.width * 0.05),
                                child: Container(
                                  color: Colors.red,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.delete,
                                      size: mq.width * 0.1,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              child: NoteCard(
                                note: notes[index],
                              ),
                            );
                          },
                        ),
                      );
              },
            ),
    );
  }
}
