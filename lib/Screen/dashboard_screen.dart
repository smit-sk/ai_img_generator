// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:logoipsum/Controller/home_ctrl.dart';
import 'package:logoipsum/Screen/explore_screen.dart';
import 'package:logoipsum/Screen/main_screen.dart';
import 'package:logoipsum/Screen/setting_screen.dart';
import 'package:logoipsum/colors.dart';
import 'package:logoipsum/widgets/custom_bottom_navbar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final HomeCtrl controller = Get.find();

  final List<Widget> screens = [
    ExploreScreen(),
    SettingScreen(),
    MainScreen(),
  ];

  void _onItemSelected(int index) {
    Get.find<HomeCtrl>().changeTabIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryTheme,
        // resizeToAvoidBottomInset: false,
        body: Obx(() => IndexedStack(
              index: controller.cIndex.value,
              children: screens,
            )),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: InkWell(
          onTap: () {
            controller.changeTabIndex(2);
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
                width: 2,
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
        bottomNavigationBar: CustomBottomNavBar());
  }
}
