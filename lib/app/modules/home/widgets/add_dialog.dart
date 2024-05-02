import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:taskapp/app/core/utils/extensions.dart';
import 'package:taskapp/app/modules/home/controllers/home_controller.dart';

class AddDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: homeCtrl.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      homeCtrl.editController.clear();
                      homeCtrl.changeTask(null);
                    },
                    icon: const Icon(Icons.close),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        // Agar ketika di tekan tidak muncul background color
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    onPressed: () {
                      if (homeCtrl.formKey.currentState!.validate()) {
                        if (homeCtrl.task.value == null) {
                          EasyLoading.showError('Pilih task type');
                        } else {
                          var sucsess = homeCtrl.updateTask(
                              homeCtrl.task.value!,
                              homeCtrl.editController.text);
                          if (sucsess) {
                            EasyLoading.showSuccess('Sucses membuat todo');
                            Get.back();
                            homeCtrl.changeTask(null);
                          } else {
                            EasyLoading.showSuccess('Todo sudah ada');
                          }
                          homeCtrl.editController.clear();
                        }
                      }
                    },
                    child: Text(
                      'Selesai',
                      style: TextStyle(
                        fontSize: 14.0.sp,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Text(
                "New Task",
                style: TextStyle(
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeCtrl.editController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!)),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tolong lengkapi judul task';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 5.0.wp,
                left: 5.0.wp,
                right: 5.0.wp,
                bottom: 2.0.wp,
              ),
              child: Text(
                "Tambah task",
                style: TextStyle(
                  fontSize: 14.0.sp,
                  color: Colors.grey,
                ),
              ),
            ),
            ...homeCtrl.tasks.map(
              (element) => Obx(
                () => InkWell(
                  onTap: () => homeCtrl.changeTask(element),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.0.wp, vertical: 3.0.wp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              IconData(element.icon,
                                  fontFamily: 'MaterialIcons'),
                              color: HexColor.fromHex(element.color),
                            ),
                            SizedBox(
                              width: 3.0.wp,
                            ),
                            Text(
                              element.title,
                              style: TextStyle(
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        if (homeCtrl.task.value == element)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
                            child: Icon(
                              Icons.check,
                              color: Colors.blue,
                              size: 14.0.sp,
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
