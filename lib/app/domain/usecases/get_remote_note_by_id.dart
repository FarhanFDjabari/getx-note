import 'package:dartz/dartz.dart';
import 'package:my_note/app/core/errors/failure.dart';
import 'package:my_note/app/data/models/note_model.dart';
import 'package:my_note/app/domain/repositories/note_repository.dart';

class GetRemoteNoteById {
  final NoteRepository noteRepository;
  GetRemoteNoteById(this.noteRepository);

  Future<Either<Failure, Note>> execute(String id) async {
    return noteRepository.getRemoteNoteById(id);
  }
}
