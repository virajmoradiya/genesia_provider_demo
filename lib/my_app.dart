part of 'main.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // localization provider
          ChangeNotifierProvider<LocalizationProvider>(
            create: (context) => LocalizationProvider()..init(),
          ),
        ],
        builder: (context, child) {
          LocalizationProvider localizationProvider =
              Provider.of<LocalizationProvider>(context, listen: true);
          return GestureDetector(
            onTap: CommonFunc.closeKeyboard,
            child: MaterialApp(
              builder: (context, child) {
                return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: const TextScaler.linear(1.0)),
                    child: Builder(builder: (context) {
                      ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                        return CustomError(errorDetails: errorDetails);
                      };
                      return child!;
                    }));
              },
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.light,
              theme: lightTheme,
              onGenerateRoute: RouteManager.onGenerateRoute,
              initialRoute: RouteManager.initRoute,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: localizationProvider.currentLocale,
              supportedLocales: supportedLocaleList,
              navigatorKey: navigatorKey,
            ),
          );
        });
  }
}
