import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:taskapp/app/core/utils/extensions.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Untuk mendapatkan task yang di tekan oleh user
    var task = controller.homeCtrl.task.value!;
    var color = HexColor.fromHex(task.color);
    return Scaffold(
        body: Form(
      key: controller.homeCtrl.formKey,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(3.0.wp),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                      controller.homeCtrl.changeTask(null);
                      controller.homeCtrl.updateTodos();
                      controller.homeCtrl.editController.clear();
                    },
                    icon: const Icon(Icons.arrow_back))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
            child: Row(
              children: [
                Icon(
                  IconData(
                    task.icon,
                    fontFamily: 'MaterialIcons',
                  ),
                  color: color,
                ),
                SizedBox(
                  width: 3.0.wp,
                ),
                Text(
                  task.title,
                  style:
                      TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Obx(
            () {
              var totalTodos = controller.homeCtrl.doingTodos.length +
                  controller.homeCtrl.doneTodos.length;
              return Padding(
                padding:
                    EdgeInsets.only(left: 16.0.wp, top: 3.0.wp, right: 16.0.wp),
                child: Row(
                  children: [
                    Text(
                      '$totalTodos Tasks',
                      style: TextStyle(fontSize: 12.0.sp, color: Colors.grey),
                    ),
                    // Membuat progress indicator
                    SizedBox(
                      width: 3.0.wp,
                    ),
                    Expanded(
                      child: StepProgressIndicator(
                        totalSteps: totalTodos == 0 ? 1 : totalTodos,
                        currentStep: controller.homeCtrl.doneTodos.length,
                        size: 5,
                        padding: 0,
                        selectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [color.withOpacity(0.5), color]),
                        unselectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey[300]!, Colors.grey[300]!],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 2.0.wp,
              horizontal: 5.0.wp,
            ),
            child: TextFormField(
              controller: controller.homeCtrl.editController,
              autofocus: true,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                prefixIcon: Icon(Icons.check_box_outline_blank,
                    color: Colors.grey[400]!),
                suffixIcon: IconButton(
                  onPressed: () {
                    if (controller.homeCtrl.formKey.currentState!.validate()) {
                      var sucsess = controller.homeCtrl.addTodo(controller.homeCtrl.editController.toString());
                      if (sucsess) {
                        EasyLoading.showSuccess('Todo item berhasil di tambahkan');
                      } else {
                        EasyLoading.showError('Todo item gagal di tambahkan');
                      }
                      controller.homeCtrl.editController.clear();
                    } 
                  },
                  icon: const Icon(Icons.done),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Tolong lengkapi judul task';
                }
                return null;
              },
            ),
          )
        ],
      ),
    ));
  }
}
