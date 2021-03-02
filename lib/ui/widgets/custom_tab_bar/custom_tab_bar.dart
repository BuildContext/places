import 'package:flutter/material.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/widgets/custom_tab_bar/custom_tab.dart';
import 'package:places/ui/widgets/custom_tab_bar/custom_tab_bar_item.dart';

typedef OnTabTap = void Function(int index);

/// Виджет - таббар с отображением элементов в виде кнопок с закругленными углами.
///
/// Принимает список[items] табов, которые являются [CustomTabBarItem]
class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  static const _tabBarHeight = 52.0;

  final List<CustomTabBarItem> items;
  final TabController controller;
  final OnTabTap onTabTap;

  const CustomTabBar({
    Key key,
    @required this.items,
    @required this.controller,
    this.onTabTap,
  })  : assert(items != null),
        assert(controller != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Container(
        height: _tabBarHeight,
        decoration: BoxDecoration(
          color: AppColors.grayF5,
          borderRadius: BorderRadius.circular(_tabBarHeight / 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _getTabs(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_tabBarHeight);

  // Формирует список виджетов для отображения табов
  List<Widget> _getTabs() {
    // определяем активный таб или нет в соответствии с этим передаем isActive
    final List<Widget> tabs = [];
    for (var i = 0; i < items.length; i++) {
      tabs.add(
        CustomTab(
          text: items[i].text,
          isActive: controller.index == i,
          activeStyle: items[i].activeStyle,
          activeBgrColor: items[i].activeBgrColor,
          style: items[i].style,
          bgrColor: items[i].bgrColor,
          onTap: () => onTabTap(i),
        ),
      );
    }
    return tabs;
  }
}
