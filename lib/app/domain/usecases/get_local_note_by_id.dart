import 'package:my_note/app/data/models/note_model.dart';
import 'package:my_note/app/domain/repositories/note_repository.dart';

class GetLocalNoteById {
  final NoteRepository noteRepository;
  GetLocalNoteById(this.noteRepository);

  Future<Note> execute(String id) async {
    return noteRepository.getLocalNoteById(id);
  }
}
