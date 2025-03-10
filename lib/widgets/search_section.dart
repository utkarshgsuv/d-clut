import 'package:ai_rag_search_engine/pages/chat_page.dart';
import 'package:ai_rag_search_engine/services/chat_web_service.dart';
import 'package:ai_rag_search_engine/theme/colors';
import 'package:ai_rag_search_engine/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final TextEditingController queryController = TextEditingController();
  @override
  void dispose() {
    
    super.dispose();
    queryController.dispose();
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
              "d-Clutter the Web",
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
                  controller: queryController,
                  decoration: InputDecoration(
                    hintText: 'Search with d-Clut AI....',
                    hintStyle: TextStyle(
                      fontFamily: GoogleFonts.firaCode().fontFamily,
                      color: AppColors.textGrey,
                      fontSize: 16,
                    ),
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
                        ChatWebService().chat(queryController.text.trim());
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              question: queryController.text.trim(),
                            ),
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
                    text: 'I’m not just AI— ',
                  ),
                  TextSpan(
                    text: 'I’m real-time intelligence',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: AppColors.whiteColor),
                  ),
                  TextSpan(
                    text:
                        '. \nKnowing what happened seconds ago and beyond, always fresh, never outdated!!\n\n',
                  ),
                  TextSpan(
                    text: 'Try and Ask me Anything!',
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
