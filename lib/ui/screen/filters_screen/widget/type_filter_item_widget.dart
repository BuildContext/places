import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight_type/sight_type.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';

/// Виджет - элемент фильтра согласно дизайну
///
/// На входе получает категорию [sightType].
/// Имеет 2 состояния выбрано или нет [isSelected],
/// при тапе вызывается [onTap]
/// Иконку получает с помощью [getIconByName] по имени [SightType.name]
class TypeFilterItemWidget extends StatelessWidget {
  final SightType sightType;
  final bool isSelected;
  final VoidCallback onTap;

  const TypeFilterItemWidget({
    Key key,
    @required this.sightType,
    @required this.isSelected,
    @required this.onTap,
  })  : assert(sightType != null),
        assert(isSelected != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                // Это чтобы иконка галочки была на своем месте.
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .accentColor
                        .withOpacity(isSelected ? 0.3 : 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          // Это для того, чтобы размер иконки подстраивался под constraints
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return SvgIcon(
                                icon: sightType.icon,
                                size: constraints.biggest.height,
                                color: Theme.of(context).accentColor,
                              );
                            },
                          ),
                        ),
                      ),
                      if (isSelected)
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.check_circle,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              sightType.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
