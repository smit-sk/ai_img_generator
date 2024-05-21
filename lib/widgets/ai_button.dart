import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logoipsum/colors.dart';

class AiButton extends StatelessWidget {
  final double height; // Custom height
  final IconData icon; // Custom icon
  final String title; // Custom text
  final Function() onPressed; // Callback for button press

  const AiButton({
    super.key,
    required this.height, // Parameter for height
    required this.icon, // Parameter for icon
    required this.title, // Parameter for text
    required this.onPressed, // Parameter for onPressed action
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('images/background.png'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.white.withOpacity(0.7),
                    offset: const Offset(0.5, 2), 
                    blurRadius: 0.1,
                  ),
                ],
                color: Colors.purple.withOpacity(1),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.purple.withOpacity(0.4),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            SizedBox(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: AppColors.darkpurple,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      title,
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.darkpurple,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
