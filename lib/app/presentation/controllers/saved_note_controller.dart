import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:my_note/app/data/models/note_model.dart';
import 'package:my_note/app/domain/usecases/delete_local_note.dart';

enum SavedNoteViewState { initial, busy, data, error }

class SavedNoteController extends GetxController {
  final removeLocalNote = GetIt.instance.get<DeleteLocalNote>();

  final savedNoteViewState = SavedNoteViewState.initial.obs;

  void removeNote(Note note) async {
    final _response = await removeLocalNote.execute(note);

    if (_response) {
      Get.back();
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          title: 'Database Error',
          message: 'Failed to remove note from database',
        ),
      );
    }
  }
}
