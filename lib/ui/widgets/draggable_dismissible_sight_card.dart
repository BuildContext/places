import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/widgets/sight_card.dart';

typedef OnSightDrop = Function(Sight sight);

/// Карточка места, которую можно двигать по LongPress
/// и удалить по свайпу налево
///
/// если на карточку при drag попадает другая каточка,
/// то вызывается [onSightDrop] с параметром что на нее упало
/// Если каточку смахнули, то вызывается [onDismissed]
class DraggableDismissibleSightCard extends StatelessWidget {
  final Sight sight;
  final VoidCallback onTap;
  final OnSightDrop onSightDrop;
  final VoidCallback onDismissed;
  final SightCardActionsBuilder actionsBuilder;

  const DraggableDismissibleSightCard({
    Key key,
    @required this.sight,
    @required this.onTap,
    @required this.onSightDrop,
    @required this.onDismissed,
    this.actionsBuilder,
  })  : assert(sight != null),
        assert(onTap != null),
        assert(onSightDrop != null),
        assert(onDismissed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<Sight>(
      key: key,
      onAccept: (droppedSight) => onSightDrop(droppedSight),
      onWillAccept: (_) => true,
      builder: (BuildContext context, List<dynamic> candidateData,
          List<dynamic> rejectedData) {
        // LayoutBuilder чтобы задать у feedback ширину
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final Widget sightWidget = SightCard(
              sight: sight,
              onTap: onTap,
              actionsBuilder: actionsBuilder,
            );

            return LongPressDraggable<Sight>(
              axis: Axis.vertical,
              data: sight,
              // Material, чтобы текстовые стили соответствовали.
              feedback: Material(
                child: Container(
                  width: constraints.maxWidth,
                  // Добавляем тень, словно элемент приподнялся
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: sightWidget,
                ),
              ),
              // Старый элемент показываем с полупрозрачностью.
              childWhenDragging: Opacity(
                opacity: 0.5,
                child: sightWidget,
              ),
              // Такая конструкция со Stack тут применяется для того, чтобы
              // закругленные уголки не заострялись. =)
              // https://github.com/flutter/flutter/issues/56812
              child: Stack(
                children: [
                  SizedBox(
                    width: constraints.maxWidth,
                    child: _DismissibleBackground(),
                  ),
                  Dismissible(
                    key: key,
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => onDismissed(),
                    child: sightWidget,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _DismissibleBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // У SightCard  - aspectRatio: 4 / 2,
    // тут повторяем
    return AspectRatio(
      aspectRatio: 4 / 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.red,
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SvgIcon(
                  icon: SvgIcons.bucket,
                  color: AppColors.white,
                ),
                const SizedBox(height: 10.0),
                Text(
                  AppStrings.sightCardDelete,
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
