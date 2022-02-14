import 'package:my_note/app/data/models/note_model.dart';
import 'package:my_note/app/domain/repositories/note_repository.dart';

class AddNewLocalNote {
  final NoteRepository repository;
  AddNewLocalNote(this.repository);

  Future<bool> execute(Note note) async {
    return repository.addNewLocalNote(note);
  }
}
