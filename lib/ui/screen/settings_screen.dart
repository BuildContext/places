import 'package:flutter/material.dart';
import 'package:places/interactor/theme_interactor.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

/// Экран настроек
class SettingsScreen extends StatefulWidget {
  static const String routeName = 'SettingsScreen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ThemeInteractor themeInteractor;

  @override
  void initState() {
    super.initState();
    themeInteractor = context.read<ThemeInteractor>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settingsAppbarTitle),
      ),
      bottomNavigationBar: const CustomBottomNavBar(index: 3),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text(AppStrings.settingsDarkTheme),
            value: themeInteractor.isDark,
            onChanged: _onChangeTheme,
          ),
          ListTile(
            title: const Text(AppStrings.settingsTutorial),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: SvgIcon(
                icon: SvgIcons.info,
                color: Theme.of(context).accentColor,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(OnboardingScreen.routeName);
            },
          ),
        ],
      ),
    );
  }

  // ignore: use_setters_to_change_properties
  void _onChangeTheme(bool newValue) => themeInteractor.isDark = newValue;
}
