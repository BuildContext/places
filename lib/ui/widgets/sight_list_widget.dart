import 'package:flutter/material.dart';

/// Виджет выводит список виджетов [children] со скроллом.
///
/// В 1 колонку на portrait или в 2 колонки на landscape
/// между элементами списка padding [spaceHeight]
class SightListWidget extends StatelessWidget {
  static const spaceHeight = 16.0;

  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  const SightListWidget({
    Key key,
    @required this.children,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
  })  : assert(children != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? ListView.separated(
            padding: padding,
            itemCount: children.length,
            itemBuilder: (context, index) => children[index],
            separatorBuilder: (context, index) =>
                const SizedBox(height: spaceHeight),
          )
        : GridView.builder(
            padding: padding,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4 / 2,
              crossAxisSpacing: spaceHeight,
              mainAxisSpacing: spaceHeight,
            ),
            itemCount: children.length,
            itemBuilder: (context, index) => children[index]);
  }
}
