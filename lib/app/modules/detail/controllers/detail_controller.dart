import 'package:get/get.dart';
import 'package:taskapp/app/modules/home/controllers/home_controller.dart';

class DetailController extends GetxController {
  //TODO: Implement DetailController
    final homeCtrl = Get.find<HomeController>();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
