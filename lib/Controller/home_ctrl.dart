import 'package:get/get_state_manager/get_state_manager.dart';

class HomeCtrl extends GetxController {
  String selectedStyle = "3d-model";
  List styles = [
    "3d-model",
    "analog-film",
    "anime",
    "cinematic",
    "comic-book",
    "digital-art",
    "enhance",
    "fantasy-art",
    "isometric",
    "line-art",
    "low-poly",
    "neon-punk",
    "origami",
    "photographic",
    "pixel-art",
    "tile-texture"
  ];

  List imgList = [];
  String prompt = "";

  bool isLoadingImage = false;

  void changeStyle(index) {
    selectedStyle = styles[index];
    update();
  }

  void onchangepropmt(value) {
    prompt = value;
    update();
  }

  void changeImgeList(value) {
    imgList = value;
    update();
  }

  void changeLoader() {
    isLoadingImage = !isLoadingImage;
  }
}
