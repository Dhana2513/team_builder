import 'package:flutter/material.dart';

class CommonAppBar extends AppBar {
  CommonAppBar({
    required String title,
    VoidCallback? onTap,
    Key? key,
  }) : super(
          key: key,
          title: InkWell(onTap: onTap, child: Text(title)),
        );
}
