import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:taskapp/app/core/utils/extensions.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var task = controller.homeCtrl.task.value!;
    var color = HexColor.fromHex(task.color);
    return Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                        controller.homeCtrl.changeTask(null);
                      },
                      icon: const Icon(Icons.arrow_back))
                ],
              ),
            ),
            Row(
              children: [
                Icon(IconData(task.icon,fontFamily: 'MaterialIcons',), color: color,)
              ],
            )
          ],
        ));
  }
}
