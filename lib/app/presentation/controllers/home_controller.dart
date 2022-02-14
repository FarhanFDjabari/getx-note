import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:my_note/app/data/datasources/local/note_local_datasources.dart';

class HomeController extends GetxController {
  var currentPage = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    await GetIt.instance.get<NoteLocalDatasources>().initDb();
  }

  @override
  void onClose() async {
    await Hive.close();
    super.onClose();
  }
}
