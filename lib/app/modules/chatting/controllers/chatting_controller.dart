import 'package:adk_tools/adk_tools.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:get/get.dart';
import 'package:mellowminds/app/api/api_connection.dart';
import 'package:mellowminds/app/data/models/chat_model.dart';
import 'package:mellowminds/app/data/models/message_model.dart';
import 'package:uuid/uuid.dart';

class ChattingController extends GetxController {
  ChatModel? chatModel;
  String? chatId;

  var listChatMessages = StatusRequestModel<List<MessageModel>>().obs;
  List<MessageModel>? listMessages;

  List<types.Message> messages = [];
  types.User user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  types.User bot = const types.User(
    id: 'bot',
  );

  @override
  void onInit() {
    super.onInit();
    getArguments();
    getChatMessages();
    user = types.User(
      id: "${chatModel?.userId}",
    );
    update();
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
      chatModel = Get.arguments['chat'];
      chatId = chatModel?.chatId;
      update();
      logSys("$chatId");
    }
  }

  getChatMessages() async {
    listChatMessages.value = StatusRequestModel.loading();
    update();
    try {
      await ApiConn.getMessagesByChatId(chatId.toString()).then((value) {
        // listChatMessages.value = value;
        if (value.statusRequest == StatusRequest.SUCCESS) {
          listMessages = value.data;
          listMessages?.forEach((element) {
            addMessage(types.TextMessage(
              author: element.sender == "bot" ? bot : user,
              id: element.chatId.toString(),
              type: types.MessageType.text,
              text: element.message.toString(),
            ));
          });
          update();
        }
      });
    } catch (e) {
      logSys(e.toString());
    }
  }

  sendNewMessage(types.TextMessage message) async {
    try {
      await ApiConn.sendNewMessage(chatId.toString(), message.text)
          .then((value) {
        // listChatMessages.value = value;
        if (value.statusRequest == StatusRequest.SUCCESS) {
          addMessage(message);
          addMessage(types.TextMessage(
            author: value.data?.sender == "bot" ? bot : user,
            id: "${value.data?.chatId}",
            type: types.MessageType.text,
            text: "${value.data?.message}",
          ));

          update();
        }
      });
    } catch (e) {
      logSys(e.toString());
    }
  }

  void addMessage(types.Message message) {
    messages.insert(0, message);
    update();
  }

  void handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    sendNewMessage(
      textMessage,
    );
    // addMessage(textMessage);
    //send message to server
  }
}
