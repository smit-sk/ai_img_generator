import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logoipsum/colors.dart';
import 'package:logoipsum/main.dart';
import 'package:logoipsum/widgets/ai_generator.dart';
import 'package:logoipsum/widgets/ai_img_view.dart';
import '../Controller/home_ctrl.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeCtrl>(builder: (homeCtrl) {
      return Container(
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
              padding: EdgeInsets.fromLTRB(16, 18, 16, 14),
              margin: isPlatformiOS
                  ? const EdgeInsets.only(top: 40)
                  : const EdgeInsets.only(top: 25),
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
              child: Row(
                children: [
                  Image.asset(
                    'images/logo.png',
                    scale: 5.5,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Logoipsum",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.purple,
                    ),
                  ),
                ],
              ),
            ),

            // Image View
            homeCtrl.imgPNG != null
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                  ),

            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // const SizedBox(width: 10),
                        Text(
                          "Select Styles",
                          style: GoogleFonts.spaceGrotesk(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/select_style');
                          },
                          child: Text(
                            "See All",
                            style: GoogleFonts.spaceGrotesk(
                                color: AppColors.purple,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        // const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 74,
                    child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              homeCtrl.changeStyle(index);
                            },
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 12),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(1),
                                      offset: const Offset(2, 2), //(x,y)
                                      blurRadius: 1,
                                    ),
                                  ],
                                  color: homeCtrl.selectedStyle ==
                                          homeCtrl.styles[index]
                                      ? AppColors.peach
                                      : AppColors.peachLight,
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        "images/anime.png",
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Text(
                                        homeCtrl.styles[index],
                                        style: GoogleFonts.spaceGrotesk(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                )),
                          );
                        }),
                  )
                ],
              ),
            ),

            AiGenerator(),
            SizedBox(
              height: 14,
            )
          ],
        ),
      );
    });
  }
}
