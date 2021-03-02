import 'package:flutter/material.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_text_styles.dart';

/// Кнопка с иконкой [icon] и текстом [text] по центру
///
/// Если иконка [icon] не задана, то выводит просто текст [text]
/// Позволяет настроить цвета, текстовый стиль
// todo deprecated. use flutter api buttons instead
class BigButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color bgColor;
  final Color color;
  final Color disabledColor;
  final Color disabledBgColor;
  final TextStyle style;
  final bool enabled;
  final VoidCallback onPressed;

  const BigButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.icon,
    this.color = AppColors.white,
    this.disabledColor = AppColors.black54,
    this.bgColor = AppColors.green,
    this.disabledBgColor = AppColors.grey,
    this.style = AppTextStyles.bigButtonText,
    this.enabled = true,
  })  : assert(text != null),
        assert(onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        height: 48.0,
        decoration: BoxDecoration(
          color: enabled ? bgColor : disabledBgColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _getLabelList(),
        ),
      ),
    );
  }

  List<Widget> _getLabelList() {
    final List<Widget> labelList = [];
    if (icon != null) {
      labelList.add(Icon(icon, color: enabled ? color : disabledColor));
      labelList.add(const SizedBox(width: 10));
    }

    labelList.add(
      Text(
        text,
        style: style.copyWith(color: enabled ? color : disabledColor),
      ),
    );

    return labelList;
  }
}
