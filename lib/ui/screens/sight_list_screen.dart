import 'package:flutter/material.dart';
import 'package:places/constants/strings_const.dart';
import 'package:places/constants/text_styles.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/widgets/card/sight_card.dart';
import 'sight_details_screen.dart';
/**
 *  SightListScreen - основной экран который
 *  отображает отфильтрованные карточки мест [SightCard]
 *  с кратким описанием доистопримечательностей.
 *  На этом экране есть возможность:
 *  1. добавить место в избранное 
 *  2. перейти на экран фильтров
 *  3. перейти на экран деталей места [SightDetailScreen]
 */

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _CustomAppBar(
        title: AppStrings.sigthListScreenTitle,
        height: 136,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(MockData.sights.length, (index) {
            return AspectRatio(
              aspectRatio: 3 / 2,
              child: SightCard(
                sight: MockData.sights[index],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;

  const _CustomAppBar({
    Key? key,
    required this.height,
    required this.title,
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
              style: AppTextStyles.largeTitleTextStyle(
                color: Theme.of(context).colorScheme.secondary,
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
