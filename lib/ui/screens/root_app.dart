import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/constants/res_path_const.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/sight_details_screen.dart';
import 'package:places/ui/screens/sight_list_screen.dart';
import 'package:places/ui/screens/visiting_screen.dart';

import 'filter/filter_screen.dart';

//Точка входа в приложение

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
        FilterScreen(),
        //SightListScreen(),
        VisitingScreen(),
        SightDetailScreen(
          sight: MockData.sights[0],
        ),
        SightListScreen(),
      ],
    );
  }

  Widget getAppBar() {
    var items = [
      pageIndex == 0 ? AppAssets.listIconFill : AppAssets.listIcon,
      pageIndex == 1 ? AppAssets.mapIconFill : AppAssets.mapIcon,
      pageIndex == 2 ? AppAssets.heartIconFill : AppAssets.heartIcon,
      pageIndex == 3 ? AppAssets.settingIconFill : AppAssets.settingIcon,
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 19),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            return RawMaterialButton(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              constraints: const BoxConstraints(
                  minWidth: 78.0, minHeight: 24.0, maxHeight: 30),
              onPressed: () {
                setState(() {
                  pageIndex = index;
                });
              },
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                SvgPicture.asset(
                  items[index],
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ]),
            );
          })),
    );
  }
}
