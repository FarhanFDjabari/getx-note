import 'package:my_note/app/data/models/note_model.dart';
import 'package:my_note/app/domain/repositories/note_repository.dart';

class DeleteLocalNote {
  final NoteRepository noteRepository;
  DeleteLocalNote(this.noteRepository);

  Future<bool> execute(Note note) async {
    return noteRepository.deleteLocalNote(note);
  }
}
