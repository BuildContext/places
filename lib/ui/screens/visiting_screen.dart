import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/colours_const.dart';
import 'package:places/constants/res_path_const.dart';
import 'package:places/constants/strings_const.dart';
import 'package:places/constants/text_styles.dart';
import 'package:places/ui/widgets/card/sight_card.dart';

import '../../mocks.dart';

class VisitingScreen extends StatefulWidget {
  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

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
    //TODO: mock data
    List planMocks = [
      MockData.sights[1],
      MockData.sights[0],
      MockData.sights[4]
    ];
    List completedMocks = [MockData.sights[3]];

    return Scaffold(
      appBar: _CustomAppBar(
        title: visitingTitleAppBar,
        height: 108,
        tabs: [visitingSwitcher1, visitingSwitcher2],
        tabController: tabController,
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          planMocks.length > 0
              ? SingleChildScrollView(
                  child: Column(
                    children: List.generate(planMocks.length, (index) {
                      return AspectRatio(
                        aspectRatio: 3 / 2,
                        child: SightCardPlanned(
                          sight: planMocks[index],
                          onTapDateSelectorButton: (() {
                            print('выбор даты');
                          }),
                          onTapDeleteButton: () {
                            print('удалить');
                          },
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
                        child: SightCardVisited(
                          sight: completedMocks[index],
                          onTapShareButton: () {
                            print('share');
                          },
                          onTapDeleteButton: () {
                            print('delete');
                          },
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

class _CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  final String title;
  final double height;
  final List<String> tabs;
  final TabController tabController;

  const _CustomAppBar({
    Key? key,
    required this.height,
    required this.title,
    required this.tabs,
    required this.tabController,
  }) : super(key: key);

  @override
  State<_CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarState extends State<_CustomAppBar> {
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
                  widget.title,
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
                      for (int i = 0; i < widget.tabs.length; i++)
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                widget.tabController.index = i;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: widget.tabController.index == i
                                    ? lmSecondaryColor
                                    : Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Center(
                                child: Text(
                                  widget.tabs[i],
                                  style: smallBoldTextStyle(
                                      color: widget.tabController.index == i
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
}
