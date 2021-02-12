import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/constants/colours_const.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getAppBar(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [
        VisitingScreen(),
        VisitingScreen(),
        SightListScreen(),
        SightListScreen(),
      ],
    );
  }

  Widget getAppBar() {
    var items = [
      pageIndex == 0
          ? 'res/icons/bottom_nav/list_fill.svg'
          : 'res/icons/bottom_nav/list.svg',
      pageIndex == 1
          ? 'res/icons/bottom_nav/map_fill.svg'
          : 'res/icons/bottom_nav/map.svg',
      pageIndex == 2
          ? 'res/icons/bottom_nav/heart_fill.svg'
          : 'res/icons/bottom_nav/heart.svg',
      pageIndex == 3
          ? 'res/icons/bottom_nav/settings_fill.svg'
          : 'res/icons/bottom_nav/settings.svg',
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 19),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            return RawMaterialButton(
              focusColor: white,
              hoverColor: white,
              highlightColor: white,
              splashColor: white,
              constraints: const BoxConstraints(
                  minWidth: 78.0, minHeight: 24.0, maxHeight: 30),
              onPressed: () {
                setState(() {
                  pageIndex = index;
                });
              },
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                SvgPicture.asset(items[index], color: black,),
              ]),
            );
          })),
    );
  }
}
