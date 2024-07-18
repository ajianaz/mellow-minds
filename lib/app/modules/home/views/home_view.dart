// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            appBar: AppBar(
              title: const Text('HomeView'),
              centerTitle: true,
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Column(
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
                  Gap(42),
                  Container(
                    height: 75,
                    width: double.infinity,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      scrollDirection: Axis.horizontal,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.blue,
                          minRadius: 36,
                        ),
                        Gap(16),
                        const CircleAvatar(
                          backgroundColor: Colors.green,
                          minRadius: 36,
                        ),
                        Gap(16),
                        const CircleAvatar(
                          backgroundColor: Colors.yellow,
                          minRadius: 36,
                        ),
                        Gap(16),
                        const CircleAvatar(
                          backgroundColor: Colors.red,
                          minRadius: 36,
                        ),
                      ],
                    ),
                  ),
                  Gap(42),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.cyanAccent,
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                    child: Column(
                      children: [
                        MagicText.subhead("What's your feeling ?"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            5,
                            (index) {
                              return Expanded(
                                child: Container(
                                  height: 150,
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  Gap(24),
                  //History
                  MagicText.subhead("Riwayat"),
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
                            "Saya merasa sedih",
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
                            "Saya merasa senang",
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
          );
        });
  }
}
