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
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Text(
            sigth_list_screen_title,
            style: largeTitleTextStyle(color: secondary),
            maxLines: 2,
          ),
        ),
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SightCard(
              sight: mocks[1],
            ),
            SightCard(
              sight: mocks[2],
            ),
            SightCard(
              sight: mocks[0],
            ),
          ],
        ),
      ),
    );
  }
}
