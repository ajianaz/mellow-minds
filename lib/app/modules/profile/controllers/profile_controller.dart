import 'dart:convert';

import 'package:adk_tools/adk_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:magic_view/magic_view.dart';
import 'package:mellowminds/app/data/models/jwt_payload_model.dart';
import 'package:mellowminds/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  JwtPayload? userInfo;

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

  checkTokenSaved() async {
    // Read value
    var accessToken = await secureStorage.read(key: ADKTools.boxToken);
    if (accessToken != null) {
      userInfo = decodeJwt(accessToken.toString());
      update();
    }
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

  Future<void> logout() async {
    // Clear tokens from secure storage
    await secureStorage.delete(key: ADKTools.boxToken);
    await secureStorage.delete(key: 'refresh_token');
    await secureStorage.delete(key: 'id_token');

    update();
  }

  confirmLogout() {
    showMagicAlertDialog(
      Get.context as BuildContext,
      content: "Are you sure to Logout?",
      iconType: EnumDialogIconType.warning,
      textPrimary: "Yes, Sure",
      textSecondary: "Cancel",
      onPrimary: () {
        Get.back();
        logout().then((value) {
          Get.offAllNamed(Routes.LOGIN);
        });
      },
      onSecondary: () {
        Get.back();
      },
    );
  }
}
