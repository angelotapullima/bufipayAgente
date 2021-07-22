import 'package:bufipay_agente/src/bloc/provider_bloc.dart';
import 'package:bufipay_agente/src/pages/home_page.dart';
import 'package:bufipay_agente/src/pages/login_page.dart';
import 'package:bufipay_agente/src/pages/splash.dart';
import 'package:bufipay_agente/src/preferences/preferences.dart';
import 'package:bufipay_agente/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new Preferences();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ProviderBloc(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (BuildContext context, Widget child) {
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(textScaleFactor: data.textScaleFactor > 2.0 ? 1.2 : data.textScaleFactor),
            child: child,
          );
        },
        localizationsDelegates: [
          //RefreshLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('es', 'ES'), // Spanish, no country code
          //const Locale('en', 'EN'), // English, no country code
        ],
        localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
          //print("change language");
          return locale;
        },
        theme: bufiPayThemeLight,
        title: 'BufiPay Agentes',
        initialRoute: 'splash',
        routes: {
          'splash': (BuildContext context) => Splash(),
          'homePage': (BuildContext context) => HomePage(),
          'login': (BuildContext context) => LoginPage(),
        },
      ),
    );
  }
}
