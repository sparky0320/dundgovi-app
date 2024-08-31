import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/router.dart';
import 'package:move_to_earn/utils/theme/theme.dart';
import 'core/translate/translator.dart';

class MyApp extends StatelessWidget {
  final String routeToJump;
  const MyApp({Key? key, required this.routeToJump}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            builder: (context, child) {
              final mediaQueryData = MediaQuery.of(context);

              return MediaQuery(
                child: child!,
                data: mediaQueryData.copyWith(
                  textScaler: TextScaler.linear(1.0),
                ),
              );
            },
            title: 'Go care',
            debugShowCheckedModeBanner: false,
            translations: Translator(),
            theme: TAppTheme.lightTheme,
            // darkTheme: TAppTheme.darkTheme,
            themeMode: ThemeMode.system,
            locale: selectedLocale1.length == 2
                ? Locale('${selectedLocale1}', '')
                : Locale('mn', ''),
            navigatorObservers: [
              FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
            ],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('mn', 'MNG'),
              const Locale('ru', 'RU'),
            ],
            initialRoute: routeToJump,
            getPages: AppRouter.routes,
            // defaultTransition: Transition.rightToLeftWithFade,
            // transitionDuration: Duration(milliseconds: 2500),
            // popGesture: true,
            // opaque: true,
          );
        },
      ),
    );
  }
}
