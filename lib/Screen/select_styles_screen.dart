// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logoipsum/Controller/home_ctrl.dart';
import 'package:logoipsum/colors.dart';
import 'package:logoipsum/main.dart';

class SelectStyleScreen extends StatelessWidget {
  const SelectStyleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryTheme,
      body: Container(
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
          children: [
            // AppBar
            Container(
              padding: EdgeInsets.fromLTRB(16, 18, 16, 12),
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
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.darkpurple,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "All Styles",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkpurple,
                    ),
                  ),
                ],
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "Select Styles",
            //         style: GoogleFonts.spaceGrotesk(
            //             fontSize: 12, fontWeight: FontWeight.w500),
            //       ),
            //       InkWell(
            //         onTap: () {
            //           // Navigator.pushNamed(
            //           //   context,
            //           //   '/select_style',
            //           // );
            //         },
            //         child: Text(
            //           "See All",
            //           style: GoogleFonts.spaceGrotesk(
            //               color: AppColors.purple,
            //               fontSize: 12,
            //               fontWeight: FontWeight.w500),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            GetBuilder<HomeCtrl>(builder: (ctrl) {
              return Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: GridView.count(
                      padding: EdgeInsets.only(
                          top: 16, left: 8, right: 8, bottom: 10),
                      childAspectRatio: 0.8,
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(ctrl.styles.length, (index) {
                        return InkWell(
                          onTap: () {
                            ctrl.changeImgeList([]);
                            Navigator.pushNamed(context, '/styled_img_view');
                            ctrl.changeStyle(index);
                          },
                          child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(1),
                                    offset: const Offset(2, 2), //(x,y)
                                    blurRadius: 1,
                                  ),
                                ],
                                color: ctrl.selectedStyle == ctrl.styles[index]
                                    ? AppColors.peach
                                    : AppColors.peachLight,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        "images/anime.png",
                                        height: 95,
                                        width: 95,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      ctrl.styles[index],
                                      maxLines: 2,
                                      style: GoogleFonts.spaceGrotesk(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              )),
                        );
                      })),
                ),
              );
            }),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
