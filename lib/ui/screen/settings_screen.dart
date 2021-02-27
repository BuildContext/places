import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/text_styles.dart';
import 'package:places/domain/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            "Настройки",
            style: TextStyle(color: Theme.of(context).accentColor), /////
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Container(
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Тёмная тема",
                    style: smallTitleTextStyle(
                            color: Theme.of(context).accentColor)
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  Switch.adaptive(
                      value: themeChange.darkTheme,
                      onChanged: (value) {
                        setState(() {
                          themeChange.darkTheme = value;
                        });
                      })
                ],
              ),
            ),
            Divider(),
            Container(
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Смотреть туториал",
                    style: smallTitleTextStyle(
                            color: Theme.of(context).accentColor)
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  SvgPicture.asset(
                    "res/icons/info.svg",
                    height: 24,
                    color: Theme.of(context).colorScheme.onError,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
