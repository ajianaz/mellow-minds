import 'package:adk_tools/adk_tools.dart';
import 'package:get/get.dart';

class FeelingConfirmationController extends GetxController {
  String? emoticonType;
  double? emoticonRate;

  var listIcons = [
    'ic_card_home.svg',
    'ic_card_work.svg',
    'ic_card_love.svg',
    'ic_card_friends.svg',
    'ic_card_health.svg',
    'ic_card_money.svg',
    'ic_card_none.svg',
  ];
  var listIconsTitle = [
    'Home',
    'Work',
    'Love',
    'Friend',
    'Health',
    'Money',
    'None',
  ];

  @override
  void onInit() {
    super.onInit();
    getArguments();
    logSys("$emoticonRate - $emoticonType");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getArguments() {
    if (Get.arguments != null) {
      emoticonType = Get.arguments['type'];
      emoticonRate = Get.arguments['rate'];
      update();
    }
  }
}
