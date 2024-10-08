import 'dart:convert';

import 'package:adk_tools/adk_tools.dart';
import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magic_view/magic_view.dart';
import 'package:mellowminds/app/api/api_connection.dart';
import 'package:mellowminds/app/data/models/chat_model.dart';
import 'package:mellowminds/app/data/models/jwt_payload_model.dart';
import 'package:mellowminds/app/routes/app_pages.dart';

class HomeController extends GetxController {
  var listChatHistory = StatusRequestModel<List<ChatModel>>().obs;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  String? accessToken;
  String? refreshToken;

  bool? isResult;

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
    'great',
    'good',
    'okay',
    'bad',
    'sad',
  ];

  checkTokenSaved() async {
    // Read value
    accessToken = await secureStorage.read(key: ADKTools.boxToken);
    if (accessToken != null) {
      jwtPayload = decodeJwt(accessToken.toString());
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkTokenSaved();
    getChatHistory();
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
    showMagicDialog(
      context,
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
            () async {
              Get.back();
              var result = await Get.toNamed(
                Routes.FEELING_CONFIRMATION,
                arguments: {
                  'type': listIconsTitle[index],
                  'rate': sliderValue,
                },
              );
              if (result != null) {
                refreshChat();
              }
            },
            text: "Next",
          ),
        ],
      ),
    );
  }

  getChatHistory() async {
    listChatHistory.value = StatusRequestModel.loading();
    update();
    try {
      await ApiConn.getChatHistory().then((value) {
        listChatHistory.value = value;
        update();
      });
    } catch (e) {
      logSys("Chat History ERROR");
      logSys(e.toString());
      listChatHistory.value = StatusRequestModel.empty();
      update();
    }
  }

  refreshChat() {
    getChatHistory();
  }
}
