// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class HomeCtrl extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchExploreData();
  }

  List exploreImgList = [];

  var cIndex = 2.obs;
  var searchText = "".obs;

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

  Uint8List? imgPNG;

  bool isLoadingImage = false;

  void changeSearchText(value) {
    searchText.value = value;
  }

  void clearCache() {
    searchText.value = "";
    imgPNG = null;
  }

  void changeTabIndex(int value) {
    cIndex(value);
  }

  void changeStyle(index) {
    selectedStyle = styles[index];
    update();
  }

  void changeLoader() {
    isLoadingImage = !isLoadingImage;
    update();
  }

  void changePNGImage(Uint8List? imageBytes) {
    imgPNG = imageBytes;
    update();

    print("Image Changed" + imgPNG!.length.toString());
  }

  fetchExploreData() async {
    String apiUrl = 'https://techsquare.tech/RbTech/Apps/image/api/inspire.php';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        exploreImgList = res['inspireList'];
        update();
      } else {
        // Handle error
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      print('Exception: $e');
    }
  }
}
