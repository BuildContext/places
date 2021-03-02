import 'package:flutter/material.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/screen/onboarding_screen/model/onboarding_item.dart';

/// Рисует центральный элемент на странице онбординга
class OnboardingContent extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingContent({
    Key key,
    @required this.item,
  })  : assert(item != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(58.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgIcon(
            icon: item.icon,
            size: 104.0,
          ),
          const SizedBox(height: 40.0),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 8.0),
          Text(
            item.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
