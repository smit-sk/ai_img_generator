// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logoipsum/colors.dart';

class LoadingBottomSheet extends StatelessWidget {
  const LoadingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35.0),
              topRight: Radius.circular(35.0),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            gradient: LinearGradient(
              colors: [
                AppColors.purple.withOpacity(0.5),
                AppColors.peach.withOpacity(0.5)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 10,
                  width: 64,
                  margin: EdgeInsets.only(top: 10, bottom: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black),
                ),
                Image.asset(
                  'images/download_img.png', // Replace with your image asset
                  scale: 3.5,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Downloading your image. Almost there!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.spaceGrotesk(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkFont),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
