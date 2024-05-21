import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logoipsum/colors.dart';

class AlertDialogBox extends StatefulWidget {
  const AlertDialogBox({Key? key}) : super(key: key);

  @override
  State<AlertDialogBox> createState() => _AlertDialogBoxState();
}

class _AlertDialogBoxState extends State<AlertDialogBox> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastLinearToSlowEaseIn,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 2,
        backgroundColor: Colors.transparent,
        child: Center(
          child: Container(
            height: 320,
            width: 250,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Container(
              height: 320,
              width: 250,
              decoration: BoxDecoration(
                // color: AppColors.purple.withOpacity(0.7),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    AppColors.purple.withOpacity(0.5),
                    AppColors.peach.withOpacity(0.5)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 140,
                    color: AppColors.purple,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Server Error",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        color: AppColors.darkFont,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Please try again",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 14,
                        color: AppColors.darkFont,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
