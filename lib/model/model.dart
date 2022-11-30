class Model {
  String? path;
  String? name;
  String? imagepath;
  String? animationpath;
  bool? animation;
  String? animidentifer;

  Model(
      {required String this.path,
      required String this.name,
      required String this.imagepath,
      required bool this.animation,
      this.animationpath,
      this.animidentifer});
}
