import 'package:flutter/material.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';

/// Виджет рисует кнопку ElevatedButton с svg-иконкой и текстом по центру
///
/// все параметры опциональны,
/// доступные иконки для [icon] в конcтантах [SvgIcons]
class IconElevatedButton extends StatelessWidget {
  final String text;
  final SvgData icon;
  final VoidCallback onPressed;

  const IconElevatedButton({
    Key key,
    this.text,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> content = [];

    if (icon != null) {
      content.add(SvgIcon(icon: icon));
    }

    if (icon != null && text != null) {
      content.add(const SizedBox(width: 10));
    }

    if (text != null) {
      content.add(Text(text));
    }

    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: content,
      ),
    );
  }
}
