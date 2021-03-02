import 'package:flutter/material.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';

/// Кнопка добавления фото
///
/// [onTap] срабатывает при тапе на кнопку
class AddPhotoWidget extends StatelessWidget {
  final VoidCallback onTap;

  const AddPhotoWidget({
    Key key,
    @required this.onTap,
  })  : assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).accentColor;

    // ClipRRect чтобы ripple не вылезал за пределы скругленных углов
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            // LayoutBuilder тут, чтобы получить высоту сверху
            // и использовать для того, чтобы сделать виджет квадратным
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: constraints.maxHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.fromBorderSide(
                      BorderSide(
                        width: 2.0,
                        color: color,
                      ),
                    ),
                  ),
                  child: Center(
                    child: SvgIcon(
                      icon: SvgIcons.plus,
                      size: 40.0,
                      color: color,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
