import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logoipsum/colors.dart';

class PermissionAlertDialog extends StatefulWidget {
  const PermissionAlertDialog({Key? key}) : super(key: key);

  @override
  State<PermissionAlertDialog> createState() => _PermissionAlertDialogState();
}

class _PermissionAlertDialogState extends State<PermissionAlertDialog> {
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
                    size: 120,
                    color: AppColors.purple.withOpacity(0.7),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Permission not granted",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        color: AppColors.darkFont,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "To allow the storage permission click on allow and grant permisson from device setting",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        color: AppColors.darkFont,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [],
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
