// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logoipsum/Controller/home_ctrl.dart';
import 'package:logoipsum/Screen/explore_screen.dart';
import 'package:logoipsum/Screen/main_screen.dart';
import 'package:logoipsum/Screen/setting_screen.dart';
import 'package:logoipsum/colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final HomeCtrl controller = Get.find();

  final List<Widget> screens = [
    MainScreen(),
    ExploreScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryTheme,
      body: Obx(() => IndexedStack(
            index: controller.cIndex.value,
            children: screens,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: InkWell(
        onTap: () {
          controller.changeTabIndex(1);
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.50),
              width: 1,
            ),
          ),
          child: CircleAvatar(
            backgroundImage: AssetImage('images/bgimg.png'),
            child: Center(
              child: Image.asset(
                'images/star.png',
                scale: 2.5,
                fit: BoxFit.contain,
              ), // Your child image here
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 80,
              padding: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Color(0xFFebd7ef),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(0.50),
                  width: 2,
                ),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Color(0xFFebd7ef),
                iconSize: 28,
                selectedLabelStyle: GoogleFonts.dmSans(fontSize: 12),
                unselectedLabelStyle: GoogleFonts.dmSans(fontSize: 12),
                currentIndex: controller.cIndex.value == 1
                    ? 0
                    : controller.cIndex.value == 2
                        ? 1
                        : controller.cIndex.value,
                onTap: (index) {
                  if (index == 0) {
                    controller.changeTabIndex(0);
                  } else if (index == 1) {
                    controller.changeTabIndex(2);
                  }
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.explore_outlined,
                    ),
                    label: 'Explore',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings_outlined,
                    ),
                    label: 'Settings',
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
