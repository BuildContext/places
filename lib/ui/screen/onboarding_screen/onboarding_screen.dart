import 'package:flutter/material.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/onboarding_screen/model/onboarding_item.dart';
import 'package:places/ui/screen/onboarding_screen/widget/onboarding_content.dart';
import 'package:places/ui/screen/onboarding_screen/widget/onboarding_progress_bar.dart';
import 'package:places/ui/screen/sight_list_screen/sight_list_screen.dart';
import 'package:places/ui/widgets/icon_elevated_button.dart';

/// Экран онбординга
class OnboardingScreen extends StatefulWidget {
  static const String routeName = 'OnboardingScreen';

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnboardingItem> _items = [
    OnboardingItem(
      title: AppStrings.onboarding1Title,
      subTitle: AppStrings.onboarding1SubTitle,
      icon: SvgIcons.onboarding1,
    ),
    OnboardingItem(
      title: AppStrings.onboarding2Title,
      subTitle: AppStrings.onboarding2SubTitle,
      icon: SvgIcons.onboarding2,
    ),
    OnboardingItem(
      title: AppStrings.onboarding3Title,
      subTitle: AppStrings.onboarding3SubTitle,
      icon: SvgIcons.onboarding3,
    )
  ];

  PageController _pageController;
  int _currentIndex = 0;
  bool _isLastPage = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          AnimatedOpacity(
            opacity: _isLastPage ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 300),
            child: TextButton(
              onPressed: _onSkipPressed,
              child: const Text(AppStrings.onboardingSkip),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            itemCount: _items.length,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
                _isLastPage = index == _items.length - 1;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingContent(item: _items[index]);
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: OnboardingProgressBar(
                total: _items.length,
                current: _currentIndex,
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: _isLastPage ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconElevatedButton(
                  text: AppStrings.onboardingStart.toUpperCase(),
                  onPressed: _onStartPressed,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Нажали на Пропустить
  void _onSkipPressed() {
    _pageController.animateToPage(
      _items.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  // Нажали на Старт
  void _onStartPressed() {
    Navigator.of(context).pushReplacementNamed(
      SightListScreen.routeName,
    );
  }
}
