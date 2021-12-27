import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/ui/global_widgets/custom_text.dart';
import 'package:todo_app/app/ui/theme/theme.dart';

class NotificationPage extends StatelessWidget {
  final String label;
  const NotificationPage({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Get.isDarkMode ? darkGreyColor : whiteColor,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: CustomText(
            title: label.toString().split("|")[0],
            fontSize: 14,
          )),
    );
  }
}
