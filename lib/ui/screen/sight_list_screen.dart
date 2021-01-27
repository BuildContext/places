import 'package:flutter/material.dart';
import 'package:places/constants/strings_const.dart';
import 'package:places/constants/text_styles.dart';
import 'package:places/constants/colours_const.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_card.dart';

///  SightListScreen - экран который рендерит массив виджетов SightCard
///  с кратким описанием доистопримечательностей,

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: sigth_list_screen_title,
        height: 136,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(mocks.length, (index) {
            return AspectRatio(
              aspectRatio: 3 / 2,
              child: SightCard(
                sight: mocks[index],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final String title;
  final double height;

  const CustomAppBar({
    Key key,
    this.title,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 80,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 280,
              maxHeight: 100,
            ),
            child: Text(
              title,
              style: largeTitleTextStyle(
                color: secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
