// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logoipsum/Controller/home_ctrl.dart';
import 'package:logoipsum/colors.dart';
import 'package:logoipsum/main.dart';
import 'package:logoipsum/widgets/ai_generator.dart';
import 'package:logoipsum/widgets/ai_img_view.dart';

class SelectedStyleScreen extends StatelessWidget {
  const SelectedStyleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryTheme,
      body: GetBuilder<HomeCtrl>(builder: (ctrl) {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
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
              Container(
                padding: EdgeInsets.fromLTRB(12, 18, 16, 10),
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
                      onPressed: () =>
                          { Navigator.pop(context)},
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.darkpurple,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      ctrl.selectedStyle,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkpurple,
                      ),
                    ),
                  ],
                ),
              ),
              AiGenerator(),
              AiImageView(),
              SizedBox(
                height: 30,
              )
            ],
          ),
        );
      }),
    );
  }
}
