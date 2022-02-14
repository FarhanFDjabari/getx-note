import 'package:my_note/app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:my_note/app/data/datasources/local/note_local_datasources.dart';
import 'package:my_note/app/data/datasources/remote/note_remote_datasources.dart';
import 'package:my_note/app/data/models/note_model.dart';
import 'package:my_note/app/domain/repositories/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {
  NoteRepositoryImpl({
    required this.localDatasources,
    required this.remoteDatasources,
  });

  final NoteLocalDatasources localDatasources;
  final NoteRemoteDatasources remoteDatasources;

  @override
  Future<bool> addNewLocalNote(Note note) async {
    final response = await localDatasources.addNewNote(note);
    return response;
  }

  @override
  Future<Either<Failure, bool>> addNewRemoteNote(Note note) async {
    try {
      final response = await remoteDatasources.addNewNote(note);
      return response.fold((l) => Left(l), (r) => Right(r));
    } on Exception catch (_) {
      return const Left(Failure('Something went wrong'));
    }
  }

  @override
  Future<bool> deleteLocalNote(Note note) async {
    final response = await localDatasources.deleteNote(note);
    return response;
  }

  @override
  Future<Either<Failure, bool>> deleteRemoteNote(Note note) async {
    try {
      final response = await remoteDatasources.deleteNote(note);
      return response.fold((l) => Left(l), (r) => Right(r));
    } on Exception catch (_) {
      return const Left(Failure('Something went wrong'));
    }
  }

  @override
  Future<Note> getLocalNoteById(String id) async {
    final response = await localDatasources.getNoteById(id);
    return response;
  }

  @override
  Future<Either<Failure, Note>> getRemoteNoteById(String id) async {
    try {
      final response = await remoteDatasources.getNoteById(id);
      return response.fold((l) => Left(l), (r) => Right(r));
    } on Exception catch (_) {
      return const Left(Failure('Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, List<Note>>> getRemoteNotes() async {
    try {
      final response = await remoteDatasources.getNotes();
      return response.fold((l) => Left(l), (r) => Right(r));
    } on Exception catch (_) {
      return const Left(Failure('Something went wrong'));
    }
  }

  @override
  Future<bool> updateLocalNote(Note note) async {
    final response = await localDatasources.updateNote(note);
    return response;
  }

  @override
  Future<Either<Failure, bool>> updateRemoteNote(Note note) async {
    try {
      final response = await remoteDatasources.updateNote(note);
      return response.fold((l) => Left(l), (r) => Right(r));
    } on Exception catch (_) {
      return const Left(Failure('Something went wrong'));
    }
  }
}
