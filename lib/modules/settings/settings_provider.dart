part of 'settings.dart';
class SettingsProvider extends BaseProvider{
  SettingsProvider({required super.context});

  bool showBackgroundVideo = false;


  @override
  void initState() {

    super.initState();
    showBackgroundVideo = PrefService.instance.isShowBgVideo;

  }


  void toggleBgVideoStatus(){
    showBackgroundVideo= !showBackgroundVideo;
    prefService.setShowBgVideoStatus = showBackgroundVideo;
    notifyListeners();
  }

  Future<void> onReset() async {
    bool? reset = await _ResetDialog.show(context: context);
    if((reset??false )&& context.mounted){

    PrefService.instance.clear();
    context.navigator.pushNamedAndRemoveUntil(WelcomeScreen.routeName, (route) => false,);
    }
  }
}
