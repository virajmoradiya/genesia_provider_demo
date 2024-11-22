import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:genesia_demo/utils/notification_helper/notification_helper.dart';
import 'package:provider/provider.dart';
import 'package:genesia_demo/components/custom_error.dart';
import 'package:genesia_demo/utils/theme.dart';

import 'core/base/language_provider.dart';
import 'generated/l10n.dart';
import 'routes/route_manager.dart';
import 'services/preferenceService/pref_manager.dart';
import 'utils/common_functions.dart';
import 'package:timezone/data/latest.dart' as tz;

part 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _init();
  _setOrientation();
  _setSystemUIOverlayStyle();
  runApp(const MyApp());
}

Future<void> _init() async {
  PrefService.instance.init();
   tz.initializeTimeZones();
  await NotificationHelper.instance.initialize();
}

void _setOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

void _setSystemUIOverlayStyle() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.black,
  ));
}
