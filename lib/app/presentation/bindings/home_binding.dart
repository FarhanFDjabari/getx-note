import 'package:get/get.dart';
import 'package:my_note/app/presentation/controllers/home_controller.dart';
import 'package:my_note/app/presentation/controllers/network_note_controller.dart';
import 'package:my_note/app/presentation/controllers/saved_note_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SavedNoteController());
    Get.lazyPut(() => NetworkNoteController());
  }
}
