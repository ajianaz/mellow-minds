import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:magic_view/factory.dart';
import 'package:magic_view/property/font/font.dart';
import 'package:adk_tools/adk_tools.dart';
import 'package:mellowminds/app/configs/constant.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ADKTools.init(
    urlDev: urlDev,
    apiKey: apiKey,
    apiDevKey: apiKey,
    appName: appName,
    appFlavor: appFlavor,
  );

  MagicFactory.initMagicFactory(
    colorBrand: Color(0xFF00cec9),
    colorBrand2: Color(0xFF503E9D),
    fontFamily: FontFamily.roboto,
    fontName: fontName,
  );

  await GetStorage.init();
  await ApiService().init();

  runApp(
    GetMaterialApp(
      title: "Mellow Minds",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
