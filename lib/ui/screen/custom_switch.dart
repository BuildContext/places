import 'package:flutter/material.dart';

// Кастомный переключатель (Tab)

class CustomSwitch extends StatefulWidget {
  final List<String> tabs;
  final TabController tabController;

  const CustomSwitch({
    Key key,
    this.tabs,
    this.tabController,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CustomSwitchState();
  }
}

class CustomSwitchState extends State<CustomSwitch>
    with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController controller2;
  Animation animation;
  bool isSwiping = true;

  GlobalKey key = GlobalKey();
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100)).then((v) {
      controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: 400));
      tabWidth = key.currentContext.size.width / 2;
      animation = Tween<double>(begin: 0, end: tabWidth).animate(controller);
      setState(() {});
      controller.addListener(() {
        setState(() {});
      });
      widget.tabController.animation.addListener(() {
        if (widget.tabController.indexIsChanging) {
          //если тап - замедляем анимацию
          isSwiping = false;
        } else if (widget.tabController.index !=
            widget.tabController.previousIndex) {
          if (!isSwiping) {
            isSwiping = true;
          }
        }

        if (isSwiping) {
          // Если свайп, ускоряем анимацию
          controller.duration = Duration(microseconds: 1);
          controller.animateTo(widget.tabController.animation.value);
        }
      });
    });
    super.initState();
  }

  double tabWidth = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.duration = Duration(milliseconds: 400);
        widget.tabController.index == 0
            ? this.controller.forward()
            : controller.reverse();
        widget.tabController.index = widget.tabController.index == 0 ? 1 : 0;
      },
      child: Container(
        key: key,
        height: 44,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(22)),
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(animation?.value ?? 0, 0),
                  child: Container(
                    height: 44,
                    width: tabWidth,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 3),
                        ]),
                  ),
                ),
              ],
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: tabWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.directions_walk),
                        SizedBox(width: 5),
                        Text(widget.tabs[0])
                      ],
                    ),
                  ),
                  Container(
                    width: tabWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.directions_walk),
                        SizedBox(width: 5),
                        Text(widget.tabs[1])
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
