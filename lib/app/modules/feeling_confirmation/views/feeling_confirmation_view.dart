import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/feeling_confirmation_controller.dart';

class FeelingConfirmationView extends GetView<FeelingConfirmationController> {
  const FeelingConfirmationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FeelingConfirmationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FeelingConfirmationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
