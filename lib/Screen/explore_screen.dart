import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logoipsum/colors.dart';
import 'package:logoipsum/main.dart';
import 'package:logoipsum/widgets/ai_img_view.dart';

import '../Controller/home_ctrl.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeCtrl>(builder: (homeCtrl) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryTheme,
              AppColors.white,
              AppColors.primaryTheme,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // App Bar
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(16, 18, 16, 14),
              margin: isPlatformiOS
                  ? EdgeInsets.only(top: 40)
                  : EdgeInsets.only(top: 25),
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 1.5,
                  ),
                ),
              ),
              child: Text(
                "EXPLORE",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkFont,
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: MasonryView(
                  listOfItem: homeCtrl.exploreImgList,
                  numberOfColumn: 2,
                  itemPadding: 6,
                  itemBuilder: (item) {
                    return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/view_image_page',
                            arguments: DataObject(
                                img: item['image'],
                                description: item['prompt']),
                          );
                        },
                        child: Image.network(item['image']));
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      );
    });
  }
}
