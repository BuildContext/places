import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/colours_const.dart';
import 'package:places/constants/res_path_const.dart';
import 'package:places/constants/strings_const.dart';
import 'package:places/constants/text_styles.dart';
import 'package:places/main.dart';
//import 'package:places/ui/screen/custom_switch.dart';
import 'package:places/ui/component/sight_card_completed.dart';
import 'package:places/ui/component/sight_card_plan.dart';

import '../../mocks.dart';

class VisitingScreen extends StatefulWidget {
  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  @override
  Widget build(BuildContext context) {
    ///mocks
    List planMocks = [mocks[1], mocks[0], mocks[4]];
    List completedMocks = [mocks[3]];

    return Scaffold(
      body: _VisitingTabBody(
        title: visitingTitleAppBar,
        tabs: [visitingSwitcher1, visitingSwitcher2],
        planMocks: planMocks,
        completedMocks: completedMocks,
      ),
    );
  }
}

class _VisitingTabBody extends StatelessWidget {
  final String title;
  final List<String> tabs;
  final List planMocks;
  final List completedMocks;

  const _VisitingTabBody(
      {Key key, this.title, this.tabs, this.planMocks, this.completedMocks})
      : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
            child: Text(
              title,
              style: TextStyle(color: Theme.of(context).accentColor), /////
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Container(
              width: 326,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: TabBar(
                  indicator: BoxDecoration(
                    color: isDarkTheme
                        ? white
                        : Theme.of(context).colorScheme.secondary, ////
                    borderRadius: BorderRadius.circular(40),
                  ),
                  unselectedLabelColor:
                      Theme.of(context).colorScheme.secondaryVariant, ////
                  labelColor: isDarkTheme
                      ? Theme.of(context).colorScheme.secondary
                      : white,
                  tabs: [
                    Tab(
                      child: Text(
                        tabs[0],
                        style: smallBoldTextStyle(color: null),
                      ),
                    ),
                    Tab(
                      child: Text(
                        tabs[1],
                        style: smallBoldTextStyle(color: null),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        body: TabBarView(
          children: [planTabView(planMocks), completedTabView(completedMocks)],
        ),
      ),
      //bottomNavigationBar: BottomNavigationMenu(),
    );
  }

  Widget completedTabView(completedMocks) {
    return completedMocks.length > 0
        ? SingleChildScrollView(
            child: Column(
              children: List.generate(completedMocks.length, (index) {
                return AspectRatio(
                  aspectRatio: 3 / 2,
                  child: SightCardCompleted(
                    sight: completedMocks[index],
                  ),
                );
              }),
            ),
          )
        : Center(
            child: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 170,
                  ),
                  SvgPicture.asset(unionIcon),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    visitingEmpty2,
                    style: subtitleTextStyle(
                      color: lmSecondaryLightColor.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    visitingEmptyDescr2,
                    style: smallTextStyle(
                      color: lmSecondaryLightColor.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
  }

  Widget planTabView(planMocks) {
    return planMocks.length > 0
        ? SingleChildScrollView(
            child: Column(
              children: List.generate(planMocks.length, (index) {
                return AspectRatio(
                  aspectRatio: 3 / 2,
                  child: SightCardPlan(
                    sight: planMocks[index],
                  ),
                );
              }),
            ),
          )
        : Center(
            child: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 170,
                  ),
                  SvgPicture.asset(cardIcon),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    visitingEmpty1,
                    style: subtitleTextStyle(
                      color: lmSecondaryLightColor.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    visitingEmptyDescr1,
                    style: smallTextStyle(
                      color: lmSecondaryLightColor.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
  }
}
