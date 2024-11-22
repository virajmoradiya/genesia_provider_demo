

import 'package:flutter/cupertino.dart';
import 'package:genesia_demo/services/preferenceService/pref_manager.dart';


class LocalizationProvider extends ChangeNotifier {
  Locale _currentLocale = Locale(SupportedLanguage.english.value);

  Locale get currentLocale => _currentLocale;

  PrefService prefService = PrefService.instance;
  

  void init() {

    _currentLocale = Locale(prefService.appLanguage.value);
    notifyListeners();
  }

  void changeLanguage(SupportedLanguage language) {
    _currentLocale = Locale(language.value);
    prefService.setAppLanguage = language;
    notifyListeners();
  }
}


enum SupportedLanguage {
  english(value: 'en');


  const SupportedLanguage({required this.value});

  final String value;
}

List<Locale> get supportedLocaleList => SupportedLanguage.values.map((lang) => Locale(lang.value)).toList();