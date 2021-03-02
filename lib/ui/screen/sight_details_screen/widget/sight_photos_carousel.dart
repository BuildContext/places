import 'package:flutter/material.dart';
import 'package:places/domain/sight_photo.dart';
import 'package:places/ui/widgets/network_image_with_spinner.dart';

/// Карусель фото  места, с индикатором.
class SightPhotosCarousel extends StatefulWidget {
  final List<SightPhoto> list;

  const SightPhotosCarousel({
    Key key,
    @required this.list,
  })  : assert(list != null),
        super(key: key);

  @override
  _SightPhotosCarouselState createState() => _SightPhotosCarouselState();
}

class _SightPhotosCarouselState extends State<SightPhotosCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            PageView.builder(
              itemCount: widget.list.length,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              itemBuilder: (context, index) {
                return NetworkImageWithSpinner(url: widget.list[index].url);
              },
            ),
            Positioned(
              bottom: 0,
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(
                  Size(constraints.maxWidth, 24.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _ProgressIndicator(
                    total: widget.list.length,
                    current: _currentIndex,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Индикатор для карусели [SightPhotosCarousel]
class _ProgressIndicator extends StatelessWidget {
  final int total;
  final int current;

  const _ProgressIndicator({
    Key key,
    @required this.total,
    @required this.current,
  })  : assert(total != null && current != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = List.generate(
      total,
      (index) => Expanded(
        child: _ProgressIndicatorItem(isActive: index == current),
      ),
    );

    return Row(children: items);
  }
}

/// Элемент индикатора карусели.
///
/// [isActive] активное состояние или нет.
/// Переключение между состояниями анимированно
class _ProgressIndicatorItem extends StatelessWidget {
  final bool isActive;

  const _ProgressIndicatorItem({
    Key key,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isActive ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
