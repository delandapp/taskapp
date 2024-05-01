import 'dart:convert';

import 'package:get/get.dart';
import 'package:taskapp/app/core/utils/keys.dart';
import 'package:taskapp/app/data/models/task.dart';
import 'package:taskapp/app/data/service/storage/services.dart';

class TaskProvider {
  final _storage = Get.find<StorageService>();

  // Membuat method / function untuk membaca data di local storage
  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString()).forEach((e) => tasks.add(Task.fromJson(e)));

    return tasks;
  }
  // Models task
  // {'tasks': [
  //   {
  //     'title' : 'work,',
  //     'color' : '0xFF123456,',
  //     'icon' : '0xe123,',
  //   }
  // ]}

   // Membuat method / function untuk menulis data di local storage
  void writeTasks(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}