// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_interpolation_to_compose_strings, avoid_print, unnecessary_null_comparison, use_build_context_synchronously, unused_local_variable

import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:logoipsum/widgets/alert_dialog.dart';
import 'package:logoipsum/widgets/loading_bottomsheet.dart';
import 'package:logoipsum/colors.dart';
import 'package:logoipsum/widgets/ai_img_view.dart';
import 'package:logoipsum/widgets/ai_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:share_plus/share_plus.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class ViewImageScreen extends StatelessWidget {
  const ViewImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as DataObject;

    return Scaffold(
      backgroundColor: AppColors.primaryTheme,
      body: Container(
        margin: const EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.purple.withOpacity(0.1),
              AppColors.peachLight,
              AppColors.purple.withOpacity(0.05),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // APP BAR
            Container(
              padding: EdgeInsets.fromLTRB(16, 18, 16, 14),
              margin: isPlatformiOS
                  ? EdgeInsets.only(top: 40)
                  : EdgeInsets.only(top: 25),
              decoration: const BoxDecoration(
                color: Colors.transparent,
                // color: AppColors.purple.withOpacity(0.1),
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
                    "Generated Image",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkpurple,
                    ),
                  ),
                ],
              ),
            ),

            // Image View

            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: AppColors.white.withOpacity(0.5))),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: args.imgType == 'network'
                              ? Image.network(
                                  args.img,
                                  fit: BoxFit.cover,
                                )
                              : Image.memory(
                                  args.img,
                                  fit: BoxFit.cover,
                                )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5, top: 16),
                        child: Text(
                          "Description",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.spaceGrotesk(
                            color: AppColors.darkpurple.withOpacity(0.6),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        args.description,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.spaceGrotesk(
                          color: AppColors.darkFont,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 1,
                              child: AiButton(
                                  height: 55,
                                  icon: Icons.share_outlined,
                                  title: "SHARE",
                                  onPressed: () async {
                                    Directory? directory;
                                    if (Platform.isAndroid) {
                                      directory =
                                          (await getExternalStorageDirectory())!;
                                    } else if (Platform.isIOS) {
                                      directory =
                                          await getApplicationDocumentsDirectory();
                                    }
                                    if (args.imgType != 'network') {
                                      File file = await saveUint8ListToFile(
                                          args.img,
                                          "${directory!.path}/ai_image.jpg");
                                      print("FILE:= " + file.path);
                                      XFile f = XFile(file.path);
                                      Share.shareXFiles([f]);
                                    } else {
                                      final file = await DefaultCacheManager()
                                          .getSingleFile(args.img);
                                      XFile f = XFile(file.path);
                                      Share.shareXFiles([f]);
                                    }
                                  })),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: AiButton(
                                  height: 55,
                                  icon: Icons.download,
                                  title: "DOWNLOAD",
                                  onPressed: () async {
                                    showModalBottomSheet(
                                        context: context,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(50.0),
                                            topRight: Radius.circular(50.0),
                                          ),
                                        ),
                                        backgroundColor: Colors.transparent,
                                        builder: (BuildContext context) {
                                          return LoadingBottomSheet();
                                        });
                                    if (args.imgType == 'network') {
                                      print("Network! Image is being Download");
                                      await _downloadImage(args.img, context)
                                          .then((value) async {
                                        if (value) {
                                          await Future.delayed(
                                              Duration(seconds: 1));
                                          Get.back();
                                        }
                                      });
                                    } else {
                                      print(
                                          "BodyBytes Image is being Download");
                                      await saveFile(args.img)
                                          .then((value) async {
                                        if (value == true) {
                                          await Future.delayed(
                                              Duration(seconds: 1));
                                          Get.back();
                                        } else {
                                          Get.back();
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const AlertDialogBox();
                                            },
                                          );
                                        }
                                      });
                                    }
                                  })),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _downloadImage(String url, context) async {
    try {
      var status = Platform.isIOS
          ? Permission.storage.request()
          : Permission.manageExternalStorage.request();
      if (await status.isGranted) {
        // Download the image
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          // Save the image to the gallery
          final result = await ImageGallerySaver.saveImage(
              Uint8List.fromList(response.bodyBytes),
              quality: 100,
              name: "ai_image");

          if (result['isSuccess']) {
            Fluttertoast.showToast(
                msg: "Image saved to gallery",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: AppColors.pinkLight,
                textColor: AppColors.darkFont,
                fontSize: 16.0);
            return true;
          } else {
            print('Failed to save image to gallery');
            return false;
          }
        } else {
          print(
              'Failed to download image. Status code: ${response.statusCode}');
          return false;
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialogBox();
          },
        );
        return false;
      }
    } catch (e) {
      print('Error downloading image: $e');
      return false;
    }
  }

  Future<File> saveUint8ListToFile(Uint8List data, String filePath) async {
    final buffer = data.buffer;
    return File(filePath)
        .writeAsBytes(buffer.asUint8List(0, data.lengthInBytes));
  }

  Future<bool?> saveFile(imgbytes) async {
    try {
      var status = Platform.isIOS
          ? Permission.storage.request()
          : Permission.manageExternalStorage.request();

      if (await status.isGranted) {
        final result = await SaverGallery.saveImage(
          imgbytes,
          quality: 60,
          name: "test_ai.jpg",
          androidRelativePath: "Pictures/appName/xx",
          androidExistNotSave: false,
        );
        if (result.isSuccess) {
          Fluttertoast.showToast(
              msg: "Image saved to gallery",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: AppColors.pinkLight,
              textColor: AppColors.darkFont,
              fontSize: 16.0);
          print(result.toString());
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print('Error downloading image: $e');
      return false;
    }
  }
}
