import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mellowminds/app/data/models/jwt_payload_model.dart';
import 'package:mellowminds/app/routes/app_pages.dart';

class LoginController extends GetxController {
  var clientID = const String.fromEnvironment('CLIENT_ID');
  var redirectUrlOauth = const String.fromEnvironment('REDIRECT_URL_OAUTH');
  var clientSecret = const String.fromEnvironment('CLIENT_SECRET');
  var issuer = const String.fromEnvironment('ISSUER');

  final FlutterAppAuth appAuth = FlutterAppAuth();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  String? accessToken;
  String? refreshToken;

  // Map<String, dynamic>? userProfile;
  JwtPayload? jwtPayload;

  Future<void> login() async {
    try {
      final AuthorizationTokenResponse? result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          clientID,
          redirectUrlOauth,
          clientSecret: clientSecret,
          issuer: issuer,
          scopes: ['openid', 'profile', 'email'],
        ),
      );
      // debugPrint(result.toString());

      if (result != null) {
        accessToken = result.accessToken;
        refreshToken = result.refreshToken;
        update();

        // debugPrint(accessToken.toString());

        // Store tokens securely
        await secureStorage.write(key: 'id_token', value: result.idToken);
        await secureStorage.write(key: 'accessToken', value: accessToken);
        await secureStorage.write(key: 'refresh_token', value: refreshToken);

        Get.toNamed(Routes.HOME);

        //Decode JWT token to Model
        // jwtPayload = decodeJwt(accessToken.toString());
        // update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  checkTokenSaved() async {
    // Read value
    accessToken = await secureStorage.read(key: 'accessToken');
    if (accessToken != null) {
      jwtPayload = decodeJwt(accessToken.toString());
      update();
    }
  }

  Future<void> logout() async {
    // Clear tokens from secure storage
    await secureStorage.delete(key: 'access_token');
    await secureStorage.delete(key: 'refresh_token');
    await secureStorage.delete(key: 'id_token');

    accessToken = null;
    update();

    // Navigate to login screen or another screen
    // Example:
    // Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
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

  @override
  void onInit() {
    super.onInit();
    debugPrint(clientID);
    debugPrint(clientSecret);
    debugPrint(issuer);
    debugPrint(redirectUrlOauth);
    logout(); //Uncomment for reset
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
}
