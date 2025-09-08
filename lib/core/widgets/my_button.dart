import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color,
    this.textColor,
  });
  final String title;
  final Function onTap;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        //padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: color ?? AppColors.mainColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
