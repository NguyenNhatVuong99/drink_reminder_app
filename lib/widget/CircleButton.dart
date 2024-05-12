// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Color iconColor;
  final bool isCorect;
  final IconData icon;
  final Function() onPressed;
  const CircleButton(
      {required this.iconColor,
      required this.icon,
      required this.onPressed,
      required this.isCorect,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: isCorect ? Colors.white : Colors.black.withOpacity(0.1),
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
            width: 48,
            height: 48,
            child: Icon(
              icon,
              color: isCorect ? iconColor : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
