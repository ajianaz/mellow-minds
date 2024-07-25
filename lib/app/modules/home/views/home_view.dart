// ignore_for_file: prefer_const_constructors

import 'package:adk_tools/adk_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:magic_view/factory.dart';
import 'package:magic_view/widget/text/MagicText.dart';
import 'package:mellowminds/app/routes/app_pages.dart';
import 'package:mellowminds/app/utils/helpers.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeHeader(
                    controller: controller,
                  ),
                  Gap(36),

                  FeelingCard(
                    controller: controller,
                  ),

                  //Chat History
                  Gap(36),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MagicText.subhead(
                          "Chat History",
                          fontSize: 20,
                        ),
                        InkWell(
                          onTap: () => controller.refreshChat(),
                          child: Icon(
                            Icons.refresh,
                          ),
                        )
                      ],
                    ),
                  ),
                  Gap(12),
                  switch (controller.listChatHistory.value.statusRequest) {
                    StatusRequest.LOADING => Center(
                        child: CircularProgressIndicator(
                          color: MagicFactory.colorBrand,
                        ),
                      ),
                    StatusRequest.NONE =>
                      Center(child: MagicText("Data Empty")),
                    StatusRequest.EMPTY =>
                      Center(child: MagicText("Data Empty")),
                    StatusRequest.ERROR =>
                      Center(child: MagicText("Get Error")),
                    StatusRequest.SUCCESS => Expanded(
                        child: ListView.builder(
                          itemCount:
                              controller.listChatHistory.value.data?.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            var item =
                                controller.listChatHistory.value.data?[index];
                            int idxIcon = controller.listIconsTitle
                                .indexOf(item!.feeling.toString());
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 24),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade500,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MagicText.subhead(
                                        "${item.feeling} with ${item.reason}",
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                      MagicText.subhead(
                                        FormatDateTime.format(
                                          value: item.createdAt as DateTime,
                                          format: DateFormat(
                                            "EEE, dd MMM yyyy",
                                          ),
                                        ),
                                        fontSize: 12,
                                        color: Colors.white60,
                                      ),
                                    ],
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    child: SvgPicture.asset(
                                      AppAsset.icon(
                                          controller.listIcons[idxIcon]),
                                      height: 32,
                                      width: 32,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                  },
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.controller,
  });

  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MagicText.subhead(
          Helper.getGreeting(),
          fontSize: 24,
        ),
        InkWell(
          onTap: () => Get.toNamed(Routes.PROFILE),
          child: MagicText.subhead(
            "${controller.jwtPayload?.name}",
            fontSize: 32,
          ),
        ),
      ],
    );
  }
}

class FeelingCard extends StatelessWidget {
  const FeelingCard({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.all(Radius.circular(24))),
      child: Column(
        children: [
          MagicText.subhead(
            "What's your feeling ?",
            color: Colors.white,
            fontSize: 32,
          ),
          Gap(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              5,
              (index) {
                return Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.openSlider(context, index);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              AppAsset.icon(
                                controller.listIcons[index],
                              ),
                              height: 42,
                            ),
                          ),
                          Gap(16),
                          MagicText.subhead(
                            controller.listIconsTitle[index].toUpperCase(),
                            textAlign: TextAlign.center,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Gap(12),
          MagicText.subhead(
            "Choose one for new chat",
            color: Colors.white60,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}
