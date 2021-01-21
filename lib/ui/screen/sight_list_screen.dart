import 'package:flutter/material.dart';
import 'package:places/constants/strings_const.dart';
import 'package:places/constants/text_styles.dart';
import 'package:places/constants/colours_const.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/widgets/custom_appBar.dart';

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
      appBar: CustomAppBar(title: sigth_list_screen_title, height: 136,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 3 / 2,
              child: SightCard(
                sight: mocks[1],
              ),
            ),
            AspectRatio(
              aspectRatio: 3 / 2,
              child: SightCard(
                sight: mocks[2],
              ),
            ),
            AspectRatio(
              aspectRatio: 3 / 2,
              child: SightCard(
                sight: mocks[0],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
