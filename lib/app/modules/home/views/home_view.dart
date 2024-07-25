// ignore_for_file: prefer_const_constructors

import 'package:adk_tools/adk_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:magic_view/widget/text/MagicText.dart';
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
                  Gap(42),

                  FeelingCard(
                    controller: controller,
                  ),

                  //Chat History
                  Gap(24),
                  MagicText.subhead(
                    "Chat History",
                  ),
                  Gap(12),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 24),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(
                              Radius.circular(24),
                            ),
                          ),
                          child: MagicText.subhead(
                            "I feel sad",
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Gap(8),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 24),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(
                              Radius.circular(24),
                            ),
                          ),
                          child: MagicText.subhead(
                            "I feel happy",
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
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
        MagicText.subhead(
          "${controller.jwtPayload?.name}",
          fontSize: 32,
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
                            controller.listIconsTitle[index],
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
