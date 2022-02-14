import 'package:dartz/dartz.dart';
import 'package:my_note/app/core/errors/failure.dart';
import 'package:my_note/app/data/models/note_model.dart';
import 'package:my_note/app/domain/repositories/note_repository.dart';

class DeleteRemoteNote {
  final NoteRepository noteRepository;
  DeleteRemoteNote(this.noteRepository);

  Future<Either<Failure, bool>> execute(Note note) async {
    return noteRepository.deleteRemoteNote(note);
  }
}
