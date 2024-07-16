import 'package:bhagavat_gita_departure/provider/language_provider.dart';
import 'package:bhagavat_gita_departure/provider/like_provider.dart';
import 'package:bhagavat_gita_departure/provider/theme_provider.dart';
import 'package:bhagavat_gita_departure/screens/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/pages/home_page.dart';
import 'screens/pages/splash.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LikeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LanguageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const MaterialWidget(),
    );
  }
}

class MaterialWidget extends StatelessWidget {
  const MaterialWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "custom",
      ),
      darkTheme: ThemeData.dark(),
      themeMode: (Provider.of<ThemeProvider>(context).currentTheme == "Light")
          ? ThemeMode.light
          : (Provider.of<ThemeProvider>(context).currentTheme == "Dark")
              ? ThemeMode.dark
              : ThemeMode.system,
      initialRoute: 'splash',
      routes: {
        '/': (_) => const HomePage(),
        'detailPage': (_) => const DetailPage(),
        'splash': (_) => const Splash(),
      },
    );
  }
}
