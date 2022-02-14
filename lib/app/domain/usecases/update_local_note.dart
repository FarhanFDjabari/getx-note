import 'package:my_note/app/data/models/note_model.dart';
import 'package:my_note/app/domain/repositories/note_repository.dart';

class UpdateLocalNote {
  final NoteRepository noteRepository;
  UpdateLocalNote(this.noteRepository);

  Future<bool> execute(Note note) async {
    return noteRepository.updateLocalNote(note);
  }
}
