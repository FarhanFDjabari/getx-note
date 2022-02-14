import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_note/app/core/errors/failure.dart';
import 'package:my_note/app/data/api/client.dart';
import 'package:my_note/app/data/models/note_model.dart';

class NoteRemoteDatasources {
  final APIClient client;
  NoteRemoteDatasources({required this.client});

  Future<Either<Failure, bool>> addNewNote(Note note) async {
    try {
      await client.addNewNote(note);
      return const Right(true);
    } on DioError catch (e) {
      return Left(Failure(e.message));
    } on Exception catch (_) {
      return const Left(Failure('Exception Error'));
    }
  }

  Future<Either<Failure, bool>> deleteNote(Note note) async {
    try {
      await client.deleteNote(note.id);
      return const Right(true);
    } on DioError catch (e) {
      return Left(Failure(e.message));
    } on Exception catch (_) {
      return const Left(Failure('Exception Error'));
    }
  }

  Future<Either<Failure, List<Note>>> getNotes() async {
    try {
      final _response = await client.getAllNotes();
      return Right(_response.data!.notes);
    } on DioError catch (e) {
      return Left(Failure(e.message));
    } on Exception catch (_) {
      return const Left(Failure('Exception Error'));
    }
  }

  Future<Either<Failure, bool>> updateNote(Note note) async {
    try {
      await client.editNote(note.id, note);
      return const Right(true);
    } on DioError catch (e) {
      return Left(Failure(e.message));
    } on Exception catch (_) {
      return const Left(Failure('Exception Error'));
    }
  }

  Future<Either<Failure, Note>> getNoteById(String id) async {
    try {
      final response = await client.getNoteById(id);
      return Right(response.data!.note);
    } on DioError catch (e) {
      return Left(Failure(e.message));
    } on Exception catch (_) {
      return const Left(Failure('Exception Error'));
    }
  }
}
