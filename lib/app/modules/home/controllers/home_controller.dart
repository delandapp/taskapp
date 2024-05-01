import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:taskapp/app/data/models/task.dart';
import 'package:taskapp/app/data/service/storage/repository.dart';

class HomeController extends GetxController {
  // Inisiasi varibel untuk bisa membaca dan menulis di localstorage
  TaskRepository taskRepository;

  // Membuat construktor untuk home Controller
  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final tasks = <Task>[].obs;
  final chipIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  bool addTask(Task task) {
    if(tasks.contains(task)) {
      return false;
    }

    tasks.add(task);
    return true;
  }
}
