import 'package:ar_application_22/pages/localAndWeb/view/localAndWeb_view_page.dart';
import 'package:ar_application_22/pages/main/controller/main_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainViewPage extends StatelessWidget {
  const MainViewPage({super.key});

  static const url = '/';
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainViewController());
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Obx(() => Text('Running on: ${controller.platformVersionG.value}\n')),
              OutlinedButton(
                  onPressed: () {
                    Get.toNamed(LocalAndWebObjectsViewPage.url);
                  },
                  child: Column(
                    children: const [
                      Text(
                        "Local & Online Objects",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        'Place 3D objects from Flutter assets and the web into the scene',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
