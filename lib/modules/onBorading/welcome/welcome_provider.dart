part of 'welcome.dart';

class WelcomeProvider extends BaseProvider {
  WelcomeProvider({required super.context});

  VideoPlayerController? videoPlayerController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialiseWelcomeVideo();
  }

  Future<void> _initialiseWelcomeVideo() async {
    videoPlayerController = VideoPlayerController.asset(Assets.video.welcomeVideo);
    await videoPlayerController?.initialize();
    isLoading = false;
    notifyListeners();
    videoPlayerController?.play();
    videoPlayerController?.setLooping(true);
  }

  @override
  void dispose() {
    videoPlayerController?.pause();
    videoPlayerController?.dispose();
    super.dispose();
  }

  void onStart() {

    CommonFunc.vibrate();
    prefService.setInitialScreen = InitialScreenType.enterYourName;
    context.navigator.pushReplacementNamed(OnboardScreen.routeName);
  }
}
