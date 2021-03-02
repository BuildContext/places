import 'package:flutter/material.dart';
import 'package:places/ui/res/app_text_styles.dart';

/// Выводит заголовок в стиле
class Label extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry padding;

  const Label({
    Key key,
    @required this.text,
    this.padding = const EdgeInsets.only(bottom: 12.0),
  })  : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text.toUpperCase(),
        style: AppTextStyles.textLabel.copyWith(
          color: Theme.of(context).disabledColor,
        ),
      ),
    );
  }
}
