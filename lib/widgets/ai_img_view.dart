// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:logoipsum/Controller/home_ctrl.dart';
import 'package:logoipsum/colors.dart';

class DataObject {
  late var img;
  late final String description;
  late final String imgType;
  DataObject(
      {required this.img, required this.description, required this.imgType});
}

class AiImageView extends StatelessWidget {
  const AiImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeCtrl>(builder: (homeCtrl) {
      return homeCtrl.imgPNG != null
          ? Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/view_image_page',
                    arguments: DataObject(
                        img: homeCtrl.imgPNG,
                        description: homeCtrl.searchText.value,
                        imgType: 'bodybytes'),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.white)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      homeCtrl.imgPNG!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
          : Expanded(
              child: Image.asset(
                'images/imgPlaceholder.png',
                scale: 4,
              ),
            );
    });
  }
}
