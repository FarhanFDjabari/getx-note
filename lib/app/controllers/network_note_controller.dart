import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:my_note/networking/client/client.dart';
import 'package:my_note/networking/models/note_model.dart';

class NetworkNoteController extends GetxController {
  final APIClient _client = APIClient(Dio());
  late Box<Note> savedNoteBox;
  var noteList = <Note>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() async {
    await getAllNotes();
    savedNoteBox = Hive.box<Note>('note_storage');
    super.onInit();
  }

  Future<void> getAllNotes() async {
    isLoading(true);
    final _response = await _client.getAllNotes();

    if (_response.status == 'success') {
      noteList.clear();
      noteList.addAll(_response.data!.notes);
      isLoading(false);
    } else {
      Get.showSnackbar(
        GetSnackBar(
          duration: const Duration(seconds: 2),
          title: 'Error ${_response.code}',
          message: 'Failed to fetch note from API',
        ),
      );
    }
  }

  void saveNote(Note note) async {
    try {
      if (!await checkSavedNote(note)) {
        savedNoteBox.add(note);
        Get.showSnackbar(
          const GetSnackBar(
            duration: Duration(seconds: 2),
            title: 'Saved',
            message: 'Note successfully saved to database',
          ),
        );
        Get.back(closeOverlays: true);
      }
    } catch (error) {
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          title: 'Database Error',
          message: 'Failed to save note',
        ),
      );
    }
  }

  Future<bool> checkSavedNote(Note value) async {
    for (var note in savedNoteBox.values) {
      if (value.id == note.id) {
        return true;
      }
    }
    return false;
  }
}
