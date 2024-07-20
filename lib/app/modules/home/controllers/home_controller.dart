import 'dart:convert';

import 'package:adk_tools/adk_tools.dart';
import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magic_view/magic_view.dart';
import 'package:mellowminds/app/data/models/jwt_payload_model.dart';
import 'package:mellowminds/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  String? accessToken;
  String? refreshToken;

  JwtPayload? jwtPayload;

  dynamic sliderValue = 100.0;

  var listIcons = [
    'ic_face_great.svg',
    'ic_face_good.svg',
    'ic_face_okay.svg',
    'ic_face_not_great.svg',
    'ic_face_bad.svg',
  ];
  var listIconsTitle = [
    'Great',
    'Good',
    'Okay',
    'Bad',
    'Sad',
  ];

  checkTokenSaved() async {
    // Read value
    accessToken = await secureStorage.read(key: 'accessToken');
    if (accessToken != null) {
      jwtPayload = decodeJwt(accessToken.toString());
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkTokenSaved();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  JwtPayload decodeJwt(String token) {
    try {
      final parts = token.split('.');
      final payload = parts[1];

      var normalizedPayload = base64Url.normalize(payload);
      var decodedPayload = base64Url.decode(normalizedPayload);
      var decodedPayloadString = utf8.decode(decodedPayload);

      Map<String, dynamic> jsonPayload = json.decode(decodedPayloadString);
      return JwtPayload.fromJson(jsonPayload);
    } catch (e) {
      throw Exception('Error decoding JWT: $e');
    }
  }

  openSlider(BuildContext context, int index) {
    showMagicDialog(context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MagicText.subhead(
              "Rate the Intensity of Your Feeling (${listIconsTitle[index]})",
            ),
            FlutterSlider(
              values: [100],
              handler: FlutterSliderHandler(
                child: SvgPicture.asset(
                  AppAsset.icon(
                    listIcons[index],
                  ),
                  height: 42,
                ),
              ),
              max: 100,
              min: 0,
              onDragging: (handlerIndex, lowerValue, upperValue) {
                sliderValue = lowerValue;
                update();
                logSys("Bawah: $sliderValue");
              },
            ),
            MagicButton(
              () {
                Get.toNamed(
                  Routes.FEELING_CONFIRMATION,
                  arguments: {
                    'type': listIconsTitle[index],
                    'rate': sliderValue,
                  },
                );
              },
              text: "Next",
            ),
          ],
        ));
  }
}
