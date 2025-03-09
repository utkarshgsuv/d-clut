import 'package:ai_rag_search_engine/pages/about_d.dart';
import 'package:ai_rag_search_engine/pages/yt_url.dart';
import 'package:ai_rag_search_engine/pages/home_page.dart';
import 'package:ai_rag_search_engine/services/chat_web_service.dart';
import 'package:ai_rag_search_engine/theme/colors';
import 'package:ai_rag_search_engine/widgets/logo.dart';
import 'package:ai_rag_search_engine/widgets/side_bar_button.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      width: isMobile ? 64 : (isCollapsed ? 64 : 150),
      color: AppColors.sideNav,
      child: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          LogoAI(
            isCollapsed: isCollapsed,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: isCollapsed
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      ChatWebService()
                          .disconnect(); // Close WebSocket when leaving the page
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );

                    },
                    child: SideBarButton(
                      isCollapsed: isCollapsed,
                      text: 'd-Search',
                      icon: Icons.search,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ChatWebService()
                          .disconnect(); // Close WebSocket when leaving the page
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => YtUrl(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: SideBarButton(
                      isCollapsed: isCollapsed,
                      text: 'd-Summarize',
                      icon: Icons.play_arrow_outlined,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ChatWebService()
                          .disconnect(); // Close WebSocket when leaving the page
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => AboutD(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );

                    },
                    child: SideBarButton(
                      isCollapsed: isCollapsed,
                      text: 'About-d',
                      icon: Icons.home_outlined,
                    ),
                  ),
                  // Spacer(),
                ],
              ),
            ),
          ),
          if (!isMobile)
            GestureDetector(
              onTap: () {
                setState(() {
                  isCollapsed = !isCollapsed;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 10,
                ),
                child: Icon(
                  isCollapsed
                      ? Icons.keyboard_arrow_right
                      : Icons.keyboard_arrow_left,
                  color: AppColors.iconGrey,
                  size: 22,
                ),
              ),
            ),
          if (!isMobile)
            SizedBox(
              height: 16,
            )
        ],
      ),
    );
  }
}
