import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskapp/app/data/service/storage/services.dart';

import 'app/routes/app_pages.dart';

void main() async {
  // Menginisiasi Penyimpanan sebelum menjalankan applikasi
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(
    GetMaterialApp(
      title: "Task Application",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
