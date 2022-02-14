import 'package:get/get.dart';
import 'package:my_note/app/presentation/controllers/saved_note_controller.dart';

class SavedNoteDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SavedNoteController());
  }
}
