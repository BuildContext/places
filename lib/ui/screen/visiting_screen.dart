import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/colours_const.dart';
import 'package:places/constants/res_path_const.dart';
import 'package:places/constants/strings_const.dart';
import 'package:places/constants/text_styles.dart';
import 'package:places/ui/screen/sight_card_completed.dart';
import 'package:places/ui/screen/sight_card_plan.dart';

import '../../mocks.dart';

class VisitingScreen extends StatefulWidget {
  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    ///mocks
    List planMocks = [mocks[1], mocks[0], mocks[4]];
    List completedMocks = [mocks[3]];

    return Scaffold(
      appBar: _CustomAppBar(
          title: visitingTitleAppBar,
          height: 108,
          tabs: [visitingSwitcher1, visitingSwitcher2],
          tabController: tabController,
          state: this),
      body: TabBarView(
        controller: tabController,
        children: [
          planMocks.length > 0
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
                ),
          completedMocks.length > 0
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
                ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final double height;
  final List<String> tabs;
  final TabController tabController;
  final State state;

  const _CustomAppBar(
      {Key key,
      @required this.height,
      this.title,
      this.tabs,
      this.tabController,
      this.state})
      : assert(height != null && title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 56,
              child: Center(
                child: Text(
                  title,
                  style: subtitleTextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
            Container(
              height: 52,
              child: Center(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      for (int i = 0; i < tabs.length; i++)
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              state.setState(() {
                                tabController.index = i;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: tabController.index == i
                                    ? lmSecondaryColor
                                    : Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Center(
                                child: Text(
                                  tabs[i],
                                  style: smallBoldTextStyle(
                                      color: tabController.index == i
                                          ? lmWhiteColor
                                          : lmSecondaryLightColor
                                              .withOpacity(0.6)),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
