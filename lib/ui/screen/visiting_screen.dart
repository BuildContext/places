import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/colours_const.dart';
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
          title: "Избранное",
          height: 108,
          tabs: ["Хочу посетить", "Посетил"],
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
                        SvgPicture.asset("res/icons/card.svg"),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Пусто",
                          style: subtitleTextStyle(
                            color: secondary2.withOpacity(0.6),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Отмечайте понравившиеся\n места и они появиятся здесь.",
                          style: smallTextStyle(
                            color: secondary2.withOpacity(0.6),
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
                        SvgPicture.asset("res/icons/union.svg"),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Пусто",
                          style: subtitleTextStyle(
                            color: secondary2.withOpacity(0.6),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Завершите маршрут, \n чтобы место попало сюда.",
                          style: smallTextStyle(
                            color: secondary2.withOpacity(0.6),
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
                    color: main,
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
                    color: Color(0xFFF5F5F5),
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
                                    ? secondary
                                    : Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Center(
                                child: Text(
                                  tabs[i],
                                  style: smallBoldTextStyle(
                                      color: tabController.index == i
                                          ? white
                                          : secondary2.withOpacity(0.6)),
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
