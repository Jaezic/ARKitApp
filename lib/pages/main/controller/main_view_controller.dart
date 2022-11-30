import 'package:ar_application_22/model/model.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class MainViewController extends GetxController {
  late ARKitController arkitController;
  RxBool cameraTurn = true.obs;
  ARKitReferenceNode? node;
  ARKitPlaneAnchor? anchor;
  RxList<Model> models = RxList();
  RxInt selectIndex = 0.obs;
  RxDouble sliderValue = 0.02.obs;
  RxBool idle = true.obs;
  void sliderUpdate(value) {
    sliderValue.value = value;
    nodeUpdate();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    models.value.add(Model(path: "models.scnassets/dash.dae", name: "새", imagepath: "./assets/images/image1.png", animation: false));
    models.value.add(Model(
      path: "models.scnassets/idleFixed.dae",
      animationpath: "models.scnassets/twist_danceFixed",
      animidentifer: 'twist_danceFixed-1',
      name: "아저씨",
      imagepath: "./assets/images/image2.png",
      animation: true,
    ));
    models.value.add(Model(
        path: "models.scnassets/marximu_idle.dae",
        name: "제리",
        imagepath: "./assets/images/image3.png",
        animation: true,
        animationpath: "models.scnassets/marximu_dancing",
        animidentifer: "marximu_dancing-1"));
    models.value.add(Model(
        path: "models.scnassets/capboy_idle.dae",
        name: "모자 쓴 소년",
        imagepath: "./assets/images/image4.png",
        animation: true,
        animationpath: "models.scnassets/capboy_dance",
        animidentifer: "capboy_dance-1"));
    super.onInit();
  }

  @override
  void onClose() {
    arkitController.dispose();
    super.onClose();
  }

  void animate() async {
    if (idle.value) {
      print(models.value[selectIndex.value].animationpath! + models.value[selectIndex.value].animidentifer!);
      await arkitController.playAnimation(
          key: 'dancing', sceneName: models.value[selectIndex.value].animationpath!, animationIdentifier: models.value[selectIndex.value].animidentifer!);
      print('anim');
    } else {
      await arkitController.stopAnimation(key: 'dancing');
      print('noanim');
    }
    idle.value = !idle.value;
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    //arkitController.addCoachingOverlay(CoachingOverlayGoal.horizontalPlane);
    arkitController.onAddNodeForAnchor = _handleAddAnchor;
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitPlaneAnchor) {
      _addPlane(arkitController, anchor);
    }
  }

  void select(int index) {
    selectIndex.value = index;
    remove();
  }

  void nodeUpdate() async {
    if (node != null) {
      node!.scale = vector.Vector3.all(sliderValue.value);
      arkitController.update(node!.name, node: node!);
    }
  }

  void remove() async {
    if (node != null) {
      arkitController.remove(node!.name);
      arkitController.removeAnchor(anchor!.identifier);
      node = null;
      idle.value = true;
      print('remove!');
      // arkitController.remove(node!.name);
    }
  }

  void _addPlane(ARKitController controller, ARKitPlaneAnchor anchor) {
    if (node != null) {
      controller.remove(node!.name);
    }
    print('new plane!');
    this.anchor = anchor;
    node = ARKitReferenceNode(
      url: models.value[selectIndex.value].path!,
      //position: vector.Vector3(0, 0, 0),
      scale: vector.Vector3.all(sliderValue.value),
    );
    controller.add(node!, parentNodeName: anchor.nodeName);
  }
}
