import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoAI extends StatelessWidget {
  final bool isCollapsed;
  const LogoAI({
    super.key,
    required this.isCollapsed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'd-Clut',
          style: TextStyle(
            fontSize: isCollapsed ? 15 : 20,
            color: Colors.white,
            fontFamily: GoogleFonts.firaCode().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'ai',
          style: TextStyle(
            fontSize: isCollapsed ? 10 : 15,
            color: Colors.white,
            fontFamily: GoogleFonts.firaCode().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
