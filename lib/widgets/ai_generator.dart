// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logoipsum/Controller/home_ctrl.dart';
import 'package:logoipsum/colors.dart';
import 'package:http/http.dart' as http;
import 'package:logoipsum/widgets/alert_dialog.dart';
import 'package:logoipsum/widgets/loading_dialog.dart';

class AiGenerator extends StatelessWidget {
  AiGenerator({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeCtrl>(builder: (homeCtrl) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Describe your image",
                style: GoogleFonts.spaceGrotesk(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLines: 5,
                initialValue: homeCtrl.searchText.value,
                onChanged: (text) {
                  homeCtrl.changeSearchText(text);
                },
                style: GoogleFonts.spaceGrotesk(
                    fontSize: 12, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  hintText: "A white bird flying over a volcano",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: AppColors.purple,
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(10)), // Border when focused
                    borderSide: BorderSide(
                      color: AppColors.purple, // Border color when focused
                      width: 2, // Border thickness when focused
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description of the image cannot be blanked';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const Loading();
                      },
                    );
                    await generateImage(homeCtrl, context).then((flag) {
                      Get.back();
                    });
                  }
                },
                child: Stack(
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/background.png'),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.white.withOpacity(0.8),
                            offset: Offset(2, 2), //(x,y)
                            blurRadius: 1,
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
                      height: 50,
                    ),
                    SizedBox(
                      height: 50,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/star.png",
                              scale: 4.0,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Generate',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 18,
                                color: AppColors.white, // Text color
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      );
    });
  }

  Future<dynamic> convertTextToImage(ctrl, context) async {
    ctrl.changeLoader();

    const baseUrl = 'https://api.stability.ai';
    final url = Uri.parse(
        '$baseUrl/v1/generation/stable-diffusion-xl-1024-v1-0/text-to-image');

    // Make the HTTP POST request to the Stability Platform API
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer sk-jwGlre8a6oxZhl5BbF0pwZb2X9k5G4wJq4J5hQhhTU2af6x1',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'cfg_scale': 15,
        'clip_guidance_preset': 'FAST_BLUE',
        'height': 1024,
        'width': 1024,
        'samples': 1,
        'steps': 15,
        'seed': 0,
        'style_preset': ctrl.selectedStyle,
        'text_prompts': [
          {
            'text': ctrl.searchText,
            'weight': 1,
          }
        ],
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      try {
        var res = json.decode(response.body);
        ctrl.changeLoader();
        ctrl.changeImgeList(res['artifacts']);
      } on Exception {
        ctrl.changeLoader();
        // return showErrorDialog('Failed to generate image exception', context);
      }
    } else {
//       {
//     "id": "0484d01c7c44feeb7c805d01d0e3ea76",
//     "message": "text_prompts: (0: (text: cannot be blank.).).",
//     "name": "bad_request"
// }

      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialogBox();
        },
      );

      // return showErrorDialog('Failed to generate image', context);
    }
  }

  getUdid() async {
    String udid = '';
    try {
      udid = await FlutterUdid.udid;
      print("UUID:-" + udid);
      return udid;
    } on PlatformException {
      udid = 'Failed to get UDID';
      return udid;
    }
  }

  Future<dynamic> generateImage(ctrl, context) async {
    ctrl.changeLoader();
    final url =
        Uri.parse('https://techsquare.tech/RbTech/Apps/image/api/code.php');

    final request = await http.post(
      url,
      body: {
        'userId': await getUdid(),
        'userLocation': "Ashburn : VA",
        'inputText':
            "${ctrl.searchText.toString()} in a ${ctrl.selectedStyle} style",
        'styleId': '',
        'styleLabel': ctrl.selectedStyle
      },
    );
    print(request.statusCode);
    if (request.statusCode == 200) {
      ctrl.changeLoader();
      ctrl.changePNGImage(request.bodyBytes);
    } else if (request.statusCode == 400) {
      ctrl.changeLoader();
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialogBox();
        },
      );
    } else if (request.statusCode == 404) {
      ctrl.changeLoader();
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialogBox();
        },
      );
    } else {
      ctrl.changeLoader();
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialogBox();
        },
      );
    }
  }
}
