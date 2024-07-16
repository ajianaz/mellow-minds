import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mellowminds/app/data/models/jwt_payload_model.dart';

class HomeController extends GetxController {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  String? accessToken;
  String? refreshToken;

  JwtPayload? jwtPayload;

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
}
