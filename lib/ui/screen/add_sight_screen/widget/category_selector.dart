import 'package:flutter/material.dart';
import 'package:places/domain/sight_type/sight_type.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';

/// Виджет - кнопка выбора категории.
///
/// Показывает выбранное значение [value]
/// или текст "Не выбрано", если [value] равно null
/// При тапе вызывается [onTap]
class CategorySelector extends StatelessWidget {
  final SightType value;
  final VoidCallback onTap;

  const CategorySelector({
    Key key,
    this.value,
    @required this.onTap,
  })  : assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final String text = value?.name ?? AppStrings.addSightDoesNotSelected;
    final Color textColor = value != null
        ? Theme.of(context).primaryColor
        : Theme.of(context).disabledColor;

    return Material(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(top: 14, bottom: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: AppTextStyles.addSightCategory.copyWith(
                  color: textColor,
                ),
              ),
              const SvgIcon(icon: SvgIcons.arrowRight)
            ],
          ),
        ),
      ),
    );
  }
}
