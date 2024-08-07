import 'package:get/get.dart';

import '../modules/chatting/bindings/chatting_binding.dart';
import '../modules/chatting/views/chatting_view.dart';
import '../modules/feeling_confirmation/bindings/feeling_confirmation_binding.dart';
import '../modules/feeling_confirmation/views/feeling_confirmation_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.FEELING_CONFIRMATION,
      page: () => const FeelingConfirmationView(),
      binding: FeelingConfirmationBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CHATTING,
      page: () => const ChattingView(),
      binding: ChattingBinding(),
    ),
  ];
}
