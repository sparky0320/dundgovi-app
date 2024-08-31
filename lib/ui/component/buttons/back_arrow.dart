import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/values.dart';

class BackArrow extends StatelessWidget {
  final VoidCallback? onClick;
  const BackArrow({super.key, this.onClick});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 32,
      icon: Icon(
        Icons.chevron_left,
        color: mainWhite,
      ),
      onPressed: onClick != null ? onClick : () => Get.back(),
    );
  }
}
