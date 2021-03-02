import 'package:flutter/material.dart';

/// Прогресс-бар для страницы онбординга
class OnboardingProgressBar extends StatelessWidget {
  final int total;
  final int current;

  const OnboardingProgressBar({
    Key key,
    @required this.total,
    @required this.current,
  })  : assert(total != null && current != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = List.generate(
      total,
      (index) => _OnboardingProgressBarItem(isActive: index == current),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: items,
    );
  }
}

/// Элемент прогресс-бара [OnboardingProgressBar]
class _OnboardingProgressBarItem extends StatelessWidget {
  final bool isActive;

  const _OnboardingProgressBarItem({Key key, this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      // SizedBox+Center чтобы элемент расширялся вокруг центра
      child: SizedBox(
        width: 16.0,
        height: 8.0,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isActive ? 16.0 : 8.0,
            decoration: BoxDecoration(
              color: isActive
                  ? Theme.of(context).accentColor
                  : Theme.of(context).disabledColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
