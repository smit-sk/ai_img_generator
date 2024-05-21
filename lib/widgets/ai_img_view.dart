// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:logoipsum/Controller/home_ctrl.dart';
import 'package:logoipsum/colors.dart';

class DataObject {
  late final Uint8List img;
  late final String selectedStyle;
  DataObject({required this.img, required this.selectedStyle});
}

class AiImageView extends StatelessWidget {
  const AiImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeCtrl>(builder: (homeCtrl) {
      return homeCtrl.imgList.isNotEmpty
          ? Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/view_image_page',
                    arguments: DataObject(
                        img: base64.decode(homeCtrl.imgList[0]['base64']),
                        selectedStyle: homeCtrl.selectedStyle),
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
                      base64.decode(homeCtrl.imgList[0]['base64']),
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
