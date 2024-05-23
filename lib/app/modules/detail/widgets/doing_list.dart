import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskapp/app/modules/home/controllers/home_controller.dart';
import 'package:taskapp/app/core/utils/extensions.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(()=> homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty ? Column(
      children: [
        Image.asset('assets/images/task.png', width: 65.0.wp,fit: BoxFit.cover),
        Text('Add Task', style: TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.bold),)
      ]
    ) : Text('Have'));
  }
}