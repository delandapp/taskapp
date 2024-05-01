import 'package:get/get.dart';
import 'package:taskapp/app/data/providers/task/provider.dart';
import 'package:taskapp/app/data/service/storage/repository.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
