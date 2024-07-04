import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typing_test/services/word_provider.dart';
import 'package:typing_test/views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String data = await loadWordList();
  WordGenerator.initializeWordList(
    data.split('\n').map((word) => word.trim()).toList(),
  );
  runApp(const MyApp());
}

Future<String> loadWordList() async {
  return await rootBundle.loadString('assets/words.txt');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SuperTyper',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orangeAccent,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.robotoMonoTextTheme(),
      ).copyWith(
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(16),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
