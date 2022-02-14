import 'package:dartz/dartz.dart';
import 'package:my_note/app/core/errors/failure.dart';
import 'package:my_note/app/data/models/note_model.dart';

abstract class NoteRepository {
  Future<Either<Failure, bool>> addNewRemoteNote(Note note);
  Future<bool> addNewLocalNote(Note note);
  Future<Either<Failure, bool>> deleteRemoteNote(Note note);
  Future<bool> deleteLocalNote(Note note);
  Future<Either<Failure, bool>> updateRemoteNote(Note note);
  Future<bool> updateLocalNote(Note note);
  Future<Either<Failure, List<Note>>> getRemoteNotes();
  Future<Either<Failure, Note>> getRemoteNoteById(String id);
  Future<Note> getLocalNoteById(String id);
}
