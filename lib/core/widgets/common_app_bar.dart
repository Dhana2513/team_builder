import 'package:flutter/material.dart';

class CommonAppBar extends AppBar {
  CommonAppBar({
    required String title,
    Key? key,
  }) : super(
          key: key,
          title: Text(title),
        );
}
