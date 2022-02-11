import 'package:get/get.dart';
import 'package:my_note/app/controllers/home_controller.dart';
import 'package:my_note/app/controllers/network_note_controller.dart';
import 'package:my_note/app/controllers/saved_note_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SavedNoteController());
    Get.lazyPut(() => NetworkNoteController());
  }
}
