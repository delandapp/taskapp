import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:taskapp/app/core/utils/extensions.dart';
import 'package:taskapp/app/data/models/task.dart';
import 'package:taskapp/app/modules/home/widgets/add_card.dart';
import 'package:taskapp/app/modules/home/widgets/task_card.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(4.0.wp),
                child: Text(
                  'My List',
                  style: TextStyle(
                    fontSize: 24.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(
                () => GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [...controller.tasks.map((element) => TaskCard(task: element)),AddCard()],
                ),
              )
            ],
          ),
        ));
  }
}
