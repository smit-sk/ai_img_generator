import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logoipsum/colors.dart';
import 'package:logoipsum/main.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryTheme,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.purple.withOpacity(0.1),
                AppColors.peachLight,
                AppColors.primaryTheme,
              ],
              stops: [
                0.0,
                0.5,
                0.9
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // APP BAR
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
                    width: 1,
                  ),
                ),
              ),
              child: Text(
                "SETTING",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkpurple,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SettingItem(
                onTap: () {},
                iconData: Icons.info_outline,
                textString: "Need Help"),
            SettingItem(
                onTap: () {},
                iconData: Icons.star_border_rounded,
                textString: "Rate Us"),
            SettingItem(
                onTap: () {},
                iconData: Icons.favorite_border_rounded,
                textString: "Share Your Feedback"),
            SettingItem(
                onTap: () {},
                iconData: Icons.note_alt_sharp,
                textString: "Privacy Policy"),
            SettingItem(
                onTap: () {},
                iconData: Icons.phone_android_rounded,
                textString: "App Version"),
            SettingItem(
                onTap: () {},
                iconData: Icons.dashboard_customize_outlined,
                textString: "More App"),
            SettingItem(
                onTap: () {},
                iconData: Icons.share_outlined,
                textString: "Share with Friends"),
          ],
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final String textString;

  const SettingItem({
    super.key,
    required this.onTap,
    required this.iconData,
    required this.textString,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white, width: 1),
          color: AppColors.pinkLight, 
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: AppColors.darkFont,
              size: 22,
            ),
            const SizedBox(width: 12),
            Text(
              textString,
              style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkFont),
            ),
          ],
        ),
      ),
    );
  }
}
