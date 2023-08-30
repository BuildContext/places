import 'package:flutter/material.dart';
import 'package:places/constants/colours_const.dart';
import 'package:places/constants/text_styles.dart';

class AcceptBigButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData? icon;
  final Color? iconColor;
  final String text;
  final Color? textColor;
  const AcceptBigButton({
    Key? key,
    this.onTap,
    this.icon,
    this.iconColor = AppColors.lmWhiteColor,
    required this.text,
    this.textColor = AppColors.lmWhiteColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.lmGreenColour,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 24,
                color: iconColor,
              ),
              const SizedBox(
                width: 10,
              ),
            ],
            Text(
              text,
              style: AppTextStyles.buttonBigTextStyle(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
