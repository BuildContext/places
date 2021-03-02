import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';

/// Рисует иконку из SVG-ассета
///
/// Доступные иконки представлены в виде констант в классе [SvgIcons]
/// Размер и цвет берется из параметров [size] и [color], если не задано, то из темы,
class SvgIcon extends StatelessWidget {
  final Color color;
  final double size;
  final SvgData icon;

  const SvgIcon({
    Key key,
    this.icon,
    this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double boxSize = size ?? iconTheme.size;
    final Color svgColor = color ?? iconTheme.color;

    return SizedBox(
      height: boxSize,
      width: boxSize,
      child: SvgPicture.asset(
        icon.path,
        color: svgColor,
        semanticsLabel: icon.semanticsLabel,
      ),
    );
  }
}
