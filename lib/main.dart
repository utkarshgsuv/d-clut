import 'package:ai_rag_search_engine/pages/about_d.dart';
import 'package:ai_rag_search_engine/theme/colors';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

void main()  {
  // WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'declut AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.submitButton,
        ),
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
        // fontFamily: GoogleFonts.firaCode().fontFamily,
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: AboutD(),
    );
  }
}
