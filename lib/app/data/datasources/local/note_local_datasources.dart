import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_note/app/data/models/note_model.dart';

class NoteLocalDatasources {
  final _noteStorage = 'note_storage';

  Future<bool> initDb() async {
    try {
      if (!kIsWeb) {
        await Hive.initFlutter();
      }

      Hive.registerAdapter(NoteAdapter());
      await Hive.openBox<Note>(_noteStorage);
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addNewNote(Note note) async {
    final savedNoteBox = Hive.box<Note>(_noteStorage);
    try {
      if (!await checkSavedNote(note)) {
        savedNoteBox.add(note);
        return true;
      }
      return false;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteDb() {
    throw UnimplementedError();
  }

  Future<bool> deleteNote(Note note) async {
    final savedNoteBox = Hive.box<Note>(_noteStorage);
    try {
      for (var item in savedNoteBox.values) {
        if (item.id == note.id) {
          savedNoteBox.delete(item.key);
          return true;
        }
      }
      return false;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Note>> getNotes() async {
    throw UnimplementedError();
  }

  Future<Note> getNoteById(String id) async {
    final savedNoteBox = Hive.box<Note>(_noteStorage);
    try {
      for (var value in savedNoteBox.values) {
        if (id == value.id) {
          final note = Note(
            id: value.id,
            title: value.title,
            body: value.body,
            tags: value.tags,
            createdAt: value.createdAt,
            updatedAt: value.updatedAt,
          );
          return note;
        }
      }
      return Note(
        id: '0',
        title: '',
        body: '',
        tags: [],
        createdAt: '',
        updatedAt: '',
      );
    } on Exception catch (e) {
      print(e);
      return Note(
        id: '0',
        title: '',
        body: '',
        tags: [],
        createdAt: '',
        updatedAt: '',
      );
    }
  }

  Future<bool> updateNote(Note note) async {
    final savedNoteBox = Hive.box<Note>(_noteStorage);
    try {
      for (var value in savedNoteBox.values) {
        if (note.id == value.id) {
          await savedNoteBox.put(value.key, note);
          return true;
        }
      }
      return false;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> checkSavedNote(Note value) async {
    final savedNoteBox = Hive.box<Note>(_noteStorage);
    for (var note in savedNoteBox.values) {
      if (value.id == note.id) {
        return true;
      }
    }
    return false;
  }
}
