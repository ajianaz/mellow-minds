import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:magic_view/magic_view.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProfileController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                title: MagicText.subhead(
                  'Profile',
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  child: Column(
                    children: [
                      MagicText.subhead(
                        "${controller.userInfo?.name}",
                        fontSize: 32,
                      ),
                      MagicText.subhead("${controller.userInfo?.email}"),
                      Gap(36),
                      MagicButton(
                        () {
                          controller.confirmLogout();
                        },
                        text: "LOGOUT",
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
