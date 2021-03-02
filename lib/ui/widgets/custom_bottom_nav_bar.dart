import 'package:flutter/material.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_list_screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

/// BottomNavigationBar - нижнее меню
///
/// нужно передать index - текущий активный элемент меню
class CustomBottomNavBar extends StatelessWidget {
  final int index;

  const CustomBottomNavBar({
    Key key,
    @required this.index,
  })  : assert(index != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Тут Hero чтобы при переходах меню не участвовало в анимации.
    // Так выглядит, словно оно persistent.
    // Как другое решение, можно было бы сделать HomeScreen с Scaffold и внутри
    // Stack или PageView для контента страниц. Но так сложнее было бы.
    return Hero(
      tag: 'bottomNavigation',
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: SvgIcon(icon: SvgIcons.list),
            activeIcon: SvgIcon(icon: SvgIcons.listFill),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgIcon(icon: SvgIcons.map),
            activeIcon: SvgIcon(icon: SvgIcons.mapFill),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgIcon(icon: SvgIcons.heart),
            activeIcon: SvgIcon(icon: SvgIcons.heartFill),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgIcon(icon: SvgIcons.settings),
            activeIcon: SvgIcon(icon: SvgIcons.settingsFill),
            label: '',
          ),
        ],
        onTap: (idx) {
          if (idx != index) {
            String route;
            switch (idx) {
              case 0:
                route = SightListScreen.routeName;
                break;
              case 1:
                // todo route карты
                break;
              case 2:
                route = VisitingScreen.routeName;
                break;
              case 3:
                route = SettingsScreen.routeName;
                break;
            }
            if (route != null) {
              Navigator.of(context).pushReplacementNamed(route);
            }
          }
        },
      ),
    );
  }
}
