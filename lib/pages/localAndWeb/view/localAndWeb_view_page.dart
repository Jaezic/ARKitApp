import 'package:ar_application_22/pages/localAndWeb/controller/localAndWeb_view_controller.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalAndWebObjectsViewPage extends StatelessWidget {
  const LocalAndWebObjectsViewPage({super.key});

  static const url = '/localAndWeb';
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocalAndWebObjectsViewController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Local & Web Objects'),
        ),
        body: Container(
            child: Stack(children: [
          ARView(
            onARViewCreated: controller.onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          Align(
              alignment: FractionalOffset.bottomCenter,
              child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     ElevatedButton(onPressed: onFileSystemObjectAtOriginButtonPressed, child: const Text("Add/Remove Filesystem\nObject at Origin")),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //ElevatedButton(onPressed: onLocalObjectAtOriginButtonPressed, child: const Text("Add/Remove Local\nObject at Origin")),
                    ElevatedButton(onPressed: controller.onWebObjectAtOriginButtonPressed, child: const Text("Add/Remove Web\nObject at Origin")),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     ElevatedButton(onPressed: onLocalObjectShuffleButtonPressed, child: const Text("Shuffle Local\nobject at Origin")),
                //     ElevatedButton(onPressed: onWebObjectShuffleButtonPressed, child: const Text("Shuffle Web\nObject at Origin")),
                //   ],
                // )
              ]))
        ])));
  }
}
