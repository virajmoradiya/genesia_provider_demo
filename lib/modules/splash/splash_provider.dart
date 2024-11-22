part of 'splash.dart';

class SplashProvider extends BaseProvider {
  SplashProvider({required super.context});


  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _changeScreen();
  }

  void _changeScreen() {
    Timer(2.seconds, () {


      switch(prefService.currentInitialScreen){
        case InitialScreenType.welcome:
          context.navigator.pushReplacementNamed(WelcomeScreen.routeName);

        case InitialScreenType.enterYourName:
          context.navigator.pushReplacementNamed(OnboardScreen.routeName);
        case InitialScreenType.dashboard:
          context.navigator.pushReplacementNamed(DashboardScreen.routeName);
      }

    });
  }
}
