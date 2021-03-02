import 'package:flutter/material.dart';
import 'package:places/ui/res/app_text_styles.dart';

/// Особый AppBar для экрана SightListScreen
class SightListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SightListAppBar({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 16.0, top: 64.0, right: 16.0, bottom: 16.0),
      child: Text(
        title,
        textAlign: TextAlign.left,
        maxLines: 2,
        style: AppTextStyles.sightListAppBar,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150.0);
}
