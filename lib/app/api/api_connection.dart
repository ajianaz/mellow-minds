import 'package:adk_tools/adk_tools.dart';
import 'package:mellowminds/app/data/models/chat_model.dart';
import 'package:mellowminds/app/data/models/message_model.dart';

class ApiConn {
  static Future<StatusRequestModel<ChatModel>> postInitChat(
      Map<String, dynamic> params) async {
    try {
      const url = '/webhook/api-init-chat';

      final response = await ApiService().request(
          url: url, method: Method.POST, isToken: true, parameters: params);

      // logSys("RESPONSE : ${response.toString()}");

      return StatusRequestModel.success(ChatModel.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }

  static Future<StatusRequestModel<List<ChatModel>>> getChatHistory() async {
    try {
      const url = '/webhook/apimm-chat-history';

      final response = await ApiService().request(
        url: url,
        method: Method.GET,
        isToken: true,
      );

      // logSys("RESPONSE : ${response.toString()}");

      final model = toDefaultModel(response);
      if (model.success == true) {
        // return StatusRequestModel.success(QrCodeModel.fromJson(model.data)); // For Single Model (not list)
        return StatusRequestModel.success(List<ChatModel>.from(
            (model.data).map((u) => ChatModel.fromJson(u))));
      } else {
        logSys(model.message.toString());
        return StatusRequestModel.error(failure(response.statusCode, model));
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<StatusRequestModel<List<MessageModel>>> getMessagesByChatId(
      String chatId) async {
    try {
      const url = '/webhook/get-message-chatid';
      var params = {"chat_id": chatId};

      final response = await ApiService().request(
          url: url, method: Method.GET, isToken: true, parameters: params);

      // logSys("RESPONSE : ${response.toString()}");

      final model = toDefaultModel(response);
      if (model.success == true) {
        // return StatusRequestModel.success(QrCodeModel.fromJson(model.data)); // For Single Model (not list)
        return StatusRequestModel.success(List<MessageModel>.from(
            (model.data).map((u) => MessageModel.fromJson(u))));
      } else {
        logSys(model.message.toString());
        return StatusRequestModel.error(failure(response.statusCode, model));
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<StatusRequestModel<MessageModel>> sendNewMessage(
      String chatId, String message) async {
    try {
      const url = '/webhook/new-message';
      var params = {"chat_id": chatId, "message": message};

      final response = await ApiService().request(
          url: url, method: Method.POST, isToken: true, parameters: params);

      // logSys("RESPONSE : ${response.toString()}");

      final model = toDefaultModel(response);
      if (model.success == true) {
        return StatusRequestModel.success(
            MessageModel.fromJson(model.data)); // For Single Model (not list)
        // return StatusRequestModel.success(List<MessageModel>.from(
        //     (model.data).map((u) => MessageModel.fromJson(u))));
      } else {
        logSys(model.message.toString());
        return StatusRequestModel.error(failure(response.statusCode, model));
      }
    } catch (e) {
      rethrow;
    }
  }
}
