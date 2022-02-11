import 'package:get/get.dart';
import 'package:my_note/app/controllers/add_note_controller.dart';

class AddNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddNoteController());
  }
}
