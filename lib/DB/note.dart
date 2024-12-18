import 'package:notes_app/models/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE notes ( 
      id $idType, 
      title $textType,
      content $textType,
      Alpha $intType,
      Red $intType,
      Green $intType,
      Blue $intType
    )
    ''');
  }

  Future<void> insertNote(Note note) async {
    final db = await instance.database;

    await db.insert(
      'notes',
      note.toMap(),
    );
  }

  Future<List<Note>> getAllNotes() async {
    final db = await instance.database;

    final maps = await db.query('notes');

    if (maps.isNotEmpty) {
      return maps.map((json) => Note.fromMap(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> updateNote(Note note) async {
    final db = await instance.database;

    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(String id) async {
    final db = await instance.database;

    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
