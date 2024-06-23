import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logoipsum/Controller/home_ctrl.dart';
import 'package:logoipsum/colors.dart';

class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final ctrl = Get.find<HomeCtrl>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 80,
        padding: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          border: Border.all(width: 2, color: Colors.white.withOpacity(0.50)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                ctrl.changeTabIndex(0);
              },
              child: Column(
                children: [
                  Icon(
                    Icons.explore_outlined,
                    size: 28,
                    color: ctrl.cIndex == 0
                        ? AppColors.darkFont
                        : AppColors.darkFont,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Explore',
                    style: GoogleFonts.dmSans(
                      color: ctrl.cIndex == 0
                          ? AppColors.darkFont
                          : AppColors.darkFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Generate',
              style: GoogleFonts.dmSans(
                color:
                    ctrl.cIndex == 1 ? AppColors.darkFont : AppColors.darkFont,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () {
                ctrl.changeTabIndex(1);
              },
              child: Column(
                children: [
                  Icon(
                    Icons.settings_outlined,
                    size: 28,
                    color: ctrl.cIndex == 1
                        ? AppColors.darkFont
                        : AppColors.darkFont,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Setting',
                    style: GoogleFonts.dmSans(
                      color: ctrl.cIndex == 1
                          ? AppColors.darkFont
                          : AppColors.darkFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
