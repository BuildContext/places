import 'package:flutter/material.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';

/// Виджет рисует кнопку TextButton с svg-иконкой и текстом по центру
///
/// все параметры опциональны
/// /// доступные иконки для [icon] в конcтантах [SvgIcons]
class IconTextButton extends StatelessWidget {
  final String text;
  final SvgData icon;
  final VoidCallback onPressed;

  const IconTextButton({
    Key key,
    this.text,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> content = [];

    if (icon != null) {
      content.add(
        SvgIcon(icon: icon),
      );
    }

    if (icon != null && text != null) {
      content.add(const SizedBox(width: 10));
    }

    if (text != null) {
      content.add(Text(text));
    }

    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: content,
      ),
    );
  }
}
