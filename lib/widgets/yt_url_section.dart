import 'package:ai_rag_search_engine/pages/yt_summary_page.dart';
import 'package:ai_rag_search_engine/theme/colors';
import 'package:ai_rag_search_engine/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YtUrlSection extends StatefulWidget {
  const YtUrlSection({super.key});

  @override
  State<YtUrlSection> createState() => _YtUrlSectionState();
}

class _YtUrlSectionState extends State<YtUrlSection> {
  final TextEditingController urlController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    urlController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isMobile)
          LogoAI(isCollapsed: false)
        else
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Colors.pink, AppColors.submitButton],
            ).createShader(bounds),
            child: Text(
              "d-Clutter the YouTube",
              style: TextStyle(
                color: AppColors.whiteColor,
                fontFamily: GoogleFonts.firaCode().fontFamily,
                fontSize: 40,
                height: 1.2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        SizedBox(
          height: 32,
        ),
        Container(
          width: 700,
          decoration: BoxDecoration(
            color: AppColors.searchBar,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.searchBarBorder,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: urlController,
                  decoration: InputDecoration(
                    hintText:
                        'Paste YouTube Video link and get notes with d-Clut AI....',
                    hintStyle: TextStyle(
                      fontFamily: GoogleFonts.firaCode().fontFamily,
                      color: AppColors.textGrey,
                      fontSize: 16,
                    ),
                    hintMaxLines: 4,
                    border: InputBorder.none,
                    //for decreasing extra space in search field
                    isDense: true,
                    contentPadding: EdgeInsets.all(0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 200), // Adjust duration if needed
                            pageBuilder: (context, animation, secondaryAnimation) =>
                                YtSummaryPage(url: urlController.text.trim()),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: AppColors.submitButton,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: AppColors.background,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: isMobile ? 12 : 18,
                  color: AppColors.textGrey,
                  fontFamily: GoogleFonts.firaCode().fontFamily,
                ),
                children: [
                  TextSpan(
                    text: 'Get a quick, ',
                  ),
                  TextSpan(
                    text: 'AI-powered ',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: AppColors.whiteColor),
                  ),
                  TextSpan(
                    text: 'summary—no need to watch the whole video!\n\n',
                  ),
                  TextSpan(
                    text: 'Try it now and save time!',
                    style: TextStyle(
                        fontSize: isMobile ? 10 : 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.submitButton),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
