import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import 'package:get/get.dart';
import 'package:magic_view/magic_view.dart';

import '../controllers/chatting_controller.dart';

class ChattingView extends GetView<ChattingController> {
  const ChattingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ChattingController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: MagicText.subhead(
                "${controller.chatModel?.feeling} with ${controller.chatModel?.reason}"
                    .toUpperCase(),
                fontSize: 20,
              ),
              centerTitle: true,
            ),
            body: Chat(
              messages: controller.messages,
              onSendPressed: controller.handleSendPressed,
              showUserAvatars: false,
              showUserNames: true,
              user: controller.user,
            ),
          );
        });
  }
}
