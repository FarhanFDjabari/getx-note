import 'package:get/get.dart';
import 'package:my_note/app/controllers/note_detail_controller.dart';

class NoteDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoteDetailController());
  }
}
