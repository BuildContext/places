import 'package:flutter/material.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';

/// Виджет рисует красивую кнопку добавления места
class AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddButton({
    Key key,
    @required this.onPressed,
  })  : assert(onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.0),
      child: Material(
        child: InkWell(
          onTap: onPressed,
          child: Ink(
            height: 48.0,
            width: 177.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                AppColors.yellow,
                Theme.of(context).accentColor,
              ]),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SvgIcon(
                  icon: SvgIcons.plus,
                  color: AppColors.white,
                ),
                const SizedBox(width: 8.0),
                Text(
                  AppStrings.sightListAddBtn.toUpperCase(),
                  style: AppTextStyles.bigButtonText
                      .copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
