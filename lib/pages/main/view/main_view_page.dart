import 'package:ar_application_22/pages/main/controller/main_view_controller.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MainViewPage extends StatelessWidget {
  const MainViewPage({super.key});

  static const url = '/';

  static Color color = Colors.black;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainViewController());
    return Scaffold(
      body: SlidingUpPanel(
        maxHeight: 400,
        minHeight: 85.0,
        parallaxEnabled: true,
        parallaxOffset: .5,
        panelBuilder: (sc) {
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 5,
                        decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: const BorderRadius.all(Radius.circular(12.0))),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'ARKit를 이용한 3D 오브젝트 증강하기',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const Spacer(),
                          if (controller.models[controller.selectIndex.value].animation!)
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      controller.animate();
                                    },
                                    icon: Icon(controller.idle.value ? Icons.play_arrow : Icons.stop)),
                                const SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          IconButton(
                              onPressed: () {
                                controller.cameraTurn.value = !controller.cameraTurn.value;
                              },
                              icon: const Icon(Icons.camera_alt)),
                        ],
                      )),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              if (controller.cameraTurn.value) {
                                controller.select(index);
                              }
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  Column(children: [
                                    controller.models.value[index].imagepath!.isEmpty
                                        ? Container(
                                            decoration: BoxDecoration(
                                                //image: DecorationImage(image: AssetImage("./assets/images/profile.jpg"))
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.circular(10)),
                                            height: 80,
                                            width: 87)
                                        : Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(image: AssetImage(controller.models.value[index].imagepath!), fit: BoxFit.fill),
                                                borderRadius: BorderRadius.circular(10)),
                                            height: 80,
                                            width: 87),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      controller.models.value[index].name!,
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                                  const SizedBox(
                                    width: 50,
                                  )
                                ],
                              ),
                            ));
                      },
                      itemCount: controller.models.length,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '객체 크기 변경',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() => SliderTheme(
                      data: const SliderThemeData(
                        activeTrackColor: Colors.black,
                        thumbColor: Colors.white,
                        activeTickMarkColor: Colors.white,
                        inactiveTrackColor: Colors.grey,
                        valueIndicatorColor: Colors.black,
                        trackHeight: 2,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 10.0,
                          elevation: 5.0,
                        ),
                        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      ),
                      child: Slider(
                          min: 0.001,
                          max: 0.05,
                          divisions: 20,
                          value: controller.sliderValue.value,
                          label: controller.sliderValue.value.toStringAsFixed(2),
                          onChanged: controller.sliderUpdate)))
                ],
              ),
            ),
          );
        },
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
        body: Obx(
          () => controller.cameraTurn.value
              ? ARKitSceneView(
                  showFeaturePoints: true,
                  planeDetection: ARPlaneDetection.horizontal,
                  onARKitViewCreated: controller.onARKitViewCreated,
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
