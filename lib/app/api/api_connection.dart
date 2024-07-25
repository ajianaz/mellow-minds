import 'package:adk_tools/adk_tools.dart';
import 'package:mellowminds/app/data/models/chat_model.dart';

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

  // static Future<StatusRequestModel<Manga>> getMangaInfo(String slug_id) async {
  //   try {
  //     const url = '/fetch-data/manga';
  //     Map<String, dynamic> parameters = {"id": slug_id};

  //     final response = await ApiService().request(
  //         url: url, method: Method.GET, isToken: false, parameters: parameters);

  //     // logSys("RESPONSE : ${response.toString()}");

  //     return StatusRequestModel.success(Manga.fromJson(response));

  //     // final model = toDefaultModel(response);
  //     // if (model.success == true) {
  //     //   // return StatusRequestModel.success(QrCodeModel.fromJson(model.data)); // For Single Model (not list)
  //     //   return StatusRequestModel.success(List<MasterModel>.from(
  //     //       (model.data).map((u) => MasterModel.fromJson(u))));
  //     // } else {
  //     //   logSys(model.message.toString());
  //     //   return StatusRequestModel.error(failure(response.statusCode, model));
  //     // }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
