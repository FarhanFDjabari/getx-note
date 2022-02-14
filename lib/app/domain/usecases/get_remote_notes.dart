import 'package:dartz/dartz.dart';
import 'package:my_note/app/core/errors/failure.dart';
import 'package:my_note/app/data/models/note_model.dart';
import 'package:my_note/app/domain/repositories/note_repository.dart';

class GetRemoteNotes {
  final NoteRepository noteRepository;
  GetRemoteNotes(this.noteRepository);

  Future<Either<Failure, List<Note>>> execute() async {
    return noteRepository.getRemoteNotes();
  }
}
