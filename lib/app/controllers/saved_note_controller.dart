import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:my_note/networking/models/note_model.dart';

class SavedNoteController extends GetxController {
  late Box<Note> savedNoteBox;

  @override
  void onInit() async {
    savedNoteBox = Hive.box<Note>('note_storage');
    super.onInit();
  }

  void removeNote(Note note) async {
    try {
      for (var item in savedNoteBox.values) {
        if (item.id == note.id) {
          savedNoteBox.delete(item.key);
          Get.back();
        }
      }
    } catch (error) {
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
