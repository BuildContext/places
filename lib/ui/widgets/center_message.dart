import 'package:flutter/material.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';

/// Виджет выводит по центру большую иконку и сообщение
class CenterMessage extends StatelessWidget {
  final SvgData icon;
  final String title;
  final String subtitle;

  const CenterMessage({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.subtitle,
  })  : assert(icon != null),
        assert(title != null),
        assert(subtitle != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).disabledColor;

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgIcon(
              icon: icon,
              size: 50.0,
              color: color,
            ),
            const SizedBox(height: 32.0),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.messageTitle.copyWith(color: color),
            ),
            const SizedBox(height: 8.0),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.messageSubtitle.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
