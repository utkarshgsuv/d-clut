import 'package:ai_rag_search_engine/theme/colors';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionFeature extends StatelessWidget {
  const DescriptionFeature({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      margin: EdgeInsets.all(isMobile ? 10 : 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [const Color.fromARGB(48, 179, 81, 51), AppColors.sideNav],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: isMobile ? 20 : 40,
            color: AppColors.submitButton,
          ),
          SizedBox(
            height: isMobile ? 8 : 12,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: TextStyle(
                  fontSize: isMobile ? 12 : 18,
                  color: AppColors.whiteColor,
                  fontFamily: GoogleFonts.firaCode().fontFamily,
                ),
                children: [
                  // d-Search
                  TextSpan(
                    text: "d-Search\n",
                    style: GoogleFonts.firaCode(
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 15 : 30,
                        color: AppColors.submitButton),
                  ),
                  const TextSpan(
                    text:
                        "A real-time AI search engine\nthat provides you with instant, up-to-date answers\n without outdated links or unnecessary clutter. ",
                  ),
                  TextSpan(
                    text:
                        "\n\nGet the latest research, breaking news,\n and reliable insights - all in one place.\n",
                    style: TextStyle(fontSize: isMobile ? 10 : 16),
                  ),
                  TextSpan(
                    text: "\n\nClick to Try\n",
                    style: TextStyle(
                        fontSize: isMobile ? 12 : 18,
                        color: AppColors.submitButton,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
