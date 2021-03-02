import 'package:flutter/material.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen.dart';
import 'package:places/ui/screen/sight_list_screen/sight_list_screen.dart';

/// Сплэш-экран
///
/// Вызывает и ждет инициализацию приложения. Ждет 2 секунды,
/// если инициализация закончилась раньше.
/// Далее автоматический переход на OnBoardingScreen или SightListScreen
/// в зависимости от того, первый раз открыли приложение или нет.
class SplashScreen extends StatefulWidget {
  static const String routeName = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future _isInitialized;

  @override
  void initState() {
    super.initState();
    _isInitialized = _initializeApp();
    _navigateToNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.yellow,
              Theme.of(context).accentColor,
            ],
          ),
        ),
        child: const Center(
          child: SvgIcon(
            icon: SvgIcons.logo,
            size: 160,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _navigateToNext() async {
    try {
      await Future.wait(
        [
          _isInitialized,
          Future.delayed(const Duration(seconds: 2)),
        ],
        // в случае ошибки _initializeApp не ждем 2 сек, чтобы обработать.
        eagerError: true,
      );
    } catch (e) {
      // если _initializeApp закончился ошибкой,
      // то тут потенциально обработка
      print('Error: $e');
    }

    // todo Сделать получение сохраненных данных о isFirstRun
    final bool isFirstRun = true;

    Navigator.of(context).pushReplacementNamed(
      isFirstRun ? OnboardingScreen.routeName : SightListScreen.routeName,
    );
  }

  // Имитируем инициализацию
  Future<void> _initializeApp() async {
    return Future.delayed(const Duration(milliseconds: 500), () {
      return;
      // return Future.error('error');
    });
  }
}
