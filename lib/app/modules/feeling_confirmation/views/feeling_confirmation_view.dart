import 'package:adk_tools/adk_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:magic_view/factory.dart';
import 'package:magic_view/magic_view.dart';

import '../controllers/feeling_confirmation_controller.dart';

class FeelingConfirmationView extends GetView<FeelingConfirmationController> {
  const FeelingConfirmationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: FeelingConfirmationController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                // title: const Text('FeelingConfirmationView'),
                centerTitle: true,
              ),
              body: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 24,
                  // horizontal: 24,
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: controller.listIcons.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: MagicFactory.colorBrand,
                            borderRadius: BorderRadius.circular(
                              24,
                            ),
                          ),
                          child: SvgPicture.asset(
                            AppAsset.icon(controller.listIcons[index]),
                          ),
                        ),
                        Gap(8),
                        MagicText.subhead(
                          controller.listIconsTitle[index],
                          fontSize: 18,
                        )
                      ],
                    );
                  },
                ),
              ));
        });
  }
}
