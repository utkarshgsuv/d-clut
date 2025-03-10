import 'package:ai_rag_search_engine/pages/home_page.dart';
import 'package:ai_rag_search_engine/pages/yt_url.dart';
import 'package:ai_rag_search_engine/services/chat_web_service.dart';
import 'package:ai_rag_search_engine/theme/colors';
import 'package:ai_rag_search_engine/widgets/description_feature.dart';
import 'package:ai_rag_search_engine/widgets/description_feature_2.dart';
import 'package:ai_rag_search_engine/widgets/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutD extends StatelessWidget {
  const AboutD({super.key});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // Sidebar (for Web/Desktop)
            if (!isMobile) SideBar(),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [Colors.pink, AppColors.submitButton],
                      ).createShader(bounds),
                      child: Text(
                        'D-Clutter.\nSimplify.\nAccelerate.',
                        style: TextStyle(
                          fontFamily: GoogleFonts.firaCode().fontFamily,
                          fontSize: isMobile ? 15 : 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 80 : 20),

                    Text(
                      'How can d-Clut AI help u?',
                      style: TextStyle(
                          fontFamily: GoogleFonts.lexendDeca().fontFamily,
                          fontSize: isMobile ? 20 : 40,
                          fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: isMobile ? 10 : 20),

                    

                    SizedBox(height: isMobile ? 15 : 30),

                   
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      YtUrl(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: DescriptionFeature2()),
                        GestureDetector(
                            onTap: () {
                              ChatWebService().connect();
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      HomePage(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: DescriptionFeature()),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: GoogleFonts.firaCode().fontFamily,
                          fontSize: isMobile ? 12 : 18,
                          color: AppColors.textGrey,
                        ),
                        children: [
                          const TextSpan(
                            text:
                                "The internet is overloaded with information,\n making it hard to find exactly what you need. ",
                          ),
                          TextSpan(
                            text: "d-Clut",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: isMobile ? 14 : 20,
                            ),
                          ),
                          const TextSpan(
                            text:
                                " is here to declutter your search experience and save you time.\n\n",
                          ),

                          
                          TextSpan(
                            text: "Stop searching. Stop scrolling.\n",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: isMobile ? 14 : 20,
                            ),
                          ),
                          TextSpan(
                            text: "Declutter your web experience with d-Clut.",
                            style: TextStyle(fontSize: isMobile ? 12 : 18),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () => _launchURL(
                          'https://www.linkedin.com/in/utkarshmaheshwari'),
                      child: Text(
                        'Contact us!',
                        style: TextStyle(
                          color: AppColors.textGrey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
