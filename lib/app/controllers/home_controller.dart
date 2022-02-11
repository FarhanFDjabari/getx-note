import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HomeController extends GetxController {
  var currentPage = 0.obs;

  @override
  void onClose() async {
    await Hive.close();
    super.onClose();
  }
}
