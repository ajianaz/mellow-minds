import 'package:adk_tools/adk_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:magic_view/magic_view.dart';
import 'package:mellowminds/app/api/api_connection.dart';
import 'package:mellowminds/app/data/models/chat_model.dart';
import 'package:mellowminds/app/routes/app_pages.dart';
import 'package:uuid/uuid.dart';

class FeelingConfirmationController extends GetxController {
  var chatModel = StatusRequestModel<ChatModel>().obs;

  String? emoticonType;
  double? emoticonRate;

  var listIcons = [
    'ic_card_home.svg',
    'ic_card_work.svg',
    'ic_card_love.svg',
    'ic_card_friends.svg',
    'ic_card_health.svg',
    'ic_card_money.svg',
    // 'ic_card_none.svg',
  ];
  var listIconsTitle = [
    'Home',
    'Work',
    'Love',
    'Friend',
    'Health',
    'Money',
    // 'None',
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

  submitData(String reason) async {
    var uuid = Uuid();
    chatModel.value = StatusRequestModel.loading();
    update();
    try {
      var params = {
        "chat_id": uuid.v4(),
        "feeling": emoticonType?.toLowerCase(),
        "percentage": emoticonRate,
        "reason": reason
      };

      await ApiConn.postInitChat(params).then((value) {
        if (value.statusRequest == StatusRequest.SUCCESS) {
          chatModel.value = value;
          update();
          Get.back(result: true);
          // Get.toNamed(Routes.CHATTING, arguments: {'chat': value.data});
        }
      });
    } catch (e) {
      logSys(e.toString());
    }
  }

  openDialog(int index) {
    showMagicAlertDialog(
      Get.context as BuildContext,
      content: "Are you sure about the choice you've made?",
      iconType: EnumDialogIconType.custom,
      icon: Column(
        children: [
          SvgPicture.asset(
            AppAsset.icon(listIcons[index]),
            height: 56,
            width: 56,
          ),
          Gap(8),
          MagicText.subhead(
            listIconsTitle[index],
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
      textPrimary: "Yes, Sure",
      textSecondary: "Cancel",
      onPrimary: () {
        Get.back();
        submitData(listIconsTitle[index].toLowerCase());
      },
      onSecondary: () {
        Get.back();
      },
    );
  }
}
