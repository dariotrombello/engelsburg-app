import 'package:engelsburg_app/src/pages/about_page.dart';
import 'package:engelsburg_app/src/pages/about_school_page.dart';
import 'package:engelsburg_app/src/pages/cafeteria_page.dart';
import 'package:engelsburg_app/src/pages/events_page.dart';
import 'package:engelsburg_app/src/pages/grades_page.dart';
import 'package:engelsburg_app/src/pages/news_page.dart';
import 'package:engelsburg_app/src/pages/register_page.dart';
import 'package:engelsburg_app/src/pages/settings/notifications_settings_page.dart';
import 'package:engelsburg_app/src/pages/settings/settings_page.dart';
import 'package:engelsburg_app/src/pages/settings/substitutes_settings_page.dart';
import 'package:engelsburg_app/src/pages/settings/theme_settings_page.dart';
import 'package:engelsburg_app/src/pages/solar_panel_page.dart';
import 'package:engelsburg_app/src/pages/substitutes_page.dart';
import 'package:engelsburg_app/src/pages/timetable_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'provider/theme.dart';

/// The Widget that configures your application.
class EngelsburgApp extends StatelessWidget {
  const EngelsburgApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light().copyWith(
          primary: themeChanger.primaryColor,
          secondary: themeChanger.secondaryColor,
        ),
      ),
      darkTheme: ThemeData.from(
        colorScheme: const ColorScheme.dark().copyWith(
          primary: themeChanger.primaryColor,
          secondary: themeChanger.secondaryColor,
        ),
      ),
      themeMode: themeChanger.themeMode,
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/news": (context) => const NewsPage(),
        "/savedArticles": (context) => const SavedArticlesPage(),
        "/cafeteria": (context) => const CafeteriaPage(),
        "/timetable": (context) => const TimetablePage(),
        "/grades": (context) => const GradesPage(),
        "/substitutes": (context) => const SubstitutesPage(),
        "/settings/substitutes": (context) => const SubstitutesSettingsPage(),
        "/settings/theme": (context) => const ThemeSettingsPage(),
        "/settings/notifications": (context) =>
            const NotificationSettingsPage(),
        "/register": (context) => const RegisterPage(),
        "/solarPanel": (context) => const SolarPanelPage(),
        "/events": (context) => EventsPage(),
        "/settings": (context) => const SettingsPage(),
        "/about": (context) => const AboutPage(),
        "/aboutSchool": (context) => const AboutSchoolPage(),
      },
    );
  }
}
