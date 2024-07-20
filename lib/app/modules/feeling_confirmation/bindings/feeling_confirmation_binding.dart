import 'package:get/get.dart';

import '../controllers/feeling_confirmation_controller.dart';

class FeelingConfirmationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeelingConfirmationController>(
      () => FeelingConfirmationController(),
    );
  }
}
