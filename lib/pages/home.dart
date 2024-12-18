import 'package:flutter/material.dart';
import 'package:notes_app/DB/note.dart';
import 'package:notes_app/controller/home.dart';
import 'package:notes_app/pages/add_note.dart';
import 'package:notes_app/shared/data.dart';
import 'package:notes_app/widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  bool isSearch = false;

  void _fetchNotes() async {
    final fetchNotes = await NotesDatabase.instance.getAllNotes();
    setState(() {
      notes = fetchNotes;
    });
  }

  @override
  void initState() {
    super.initState();

    _fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearch
            ? TextField(
                cursorColor: Colors.white,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
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
                  fontSize: 35,
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
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: Icon(isSearch ? Icons.search_off : Icons.search),
          ),
          SizedBox(width: 10),
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
              padding: EdgeInsets.all(20),
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
                        padding: EdgeInsets.all(15),
                        child: ListView.builder(
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(notes[index].id),
                              onDismissed: (direction) {
                                removeNote(context, notes[index]);
                              },
                              background: Padding(
                                padding: EdgeInsets.only(bottom: 16),
                                child: Container(
                                  color: Colors.red,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.delete,
                                      size: 35,
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
