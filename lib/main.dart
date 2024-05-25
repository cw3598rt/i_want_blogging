import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_want_blogging/screens/home_page.dart';

Future main() async {
  await dotenv.load(fileName: "assets/env");
  Gemini.init(apiKey: "${dotenv.env['GEMINI']}");
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI BLOGGING',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 190, 116)),
        useMaterial3: true,
      ),
      home: HomePageScreen(),
    );
  }
}
