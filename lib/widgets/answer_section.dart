import 'dart:async';

import 'package:ai_rag_search_engine/services/chat_web_service.dart';
import 'package:ai_rag_search_engine/theme/colors';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AnswerSection extends StatefulWidget {
  const AnswerSection({super.key});

  @override
  State<AnswerSection> createState() => _AnswerSectionState();
}

class _AnswerSectionState extends State<AnswerSection> {
  bool isLoading = true;
  String fullResponse = ''' # 🏏 Cricket Live Updates

## 🏆 India vs Australia - 4th Test

**Match:** India vs Australia  
**Date:** 25th December 2024  
**Venue:** Melbourne Cricket Ground (MCG)  
**Live Score:** 

---

## 🎉 Boxing Day Test - Live Action!

The most awaited **Boxing Day Test** is here! Witness the action as **India** takes on **Australia** in this historic match.

📺 **Watch Live:** 

🏏 **Current Highlights:**  
- 🇦🇺 Australian batters showing resilience  
- 🏏 4 Australian batters score **half-centuries**  
- 🎯 Can India make a comeback?  

📢 Stay updated with the latest.

---

### 🔥 Top Performers
| Player           | Team     | Runs  | Wickets |
|----------------|---------|------|---------|
| Virat Kohli     | 🇮🇳 India  | 85   | -       |
| Steve Smith     | 🇦🇺 Australia | 102  | -       |
| Pat Cummins     | 🇦🇺 Australia | 25   | 4       |
| Jasprit Bumrah  | 🇮🇳 India  | 10   | 3       |

🚀 More updates coming soon!

---

## 📢 Stay Tuned for More Cricket News!

For the latest scores, match updates, and expert analysis, visit **Cricket Central**.  
📌 Follow us on Twitter and Instagram for real-time updates.

🏏 **Cricket is not just a game; it's an emotion!** 🏆🔥

''';
  StreamSubscription? _subscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subscription = ChatWebService().contentResultStream.listen((data) {
      if (isLoading) {
        fullResponse = "";
      }
      setState(() {
        fullResponse += data['data'];
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'd-Clut',
          style: TextStyle(
            fontSize: 18,
            fontFamily: GoogleFonts.firaCode().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        // SizedBox(
        //   height: 16,
        // ),
        Skeletonizer(
          enabled: isLoading,
          effect: ShimmerEffect(
            baseColor: AppColors.sideNav,
            highlightColor: AppColors.submitButton,
            duration: Duration(seconds: 1),
          ),
          child: Markdown(
            selectable: true,
            data: fullResponse,
            shrinkWrap: true,
            styleSheet: MarkdownStyleSheet(
              pPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              p: TextStyle(fontSize: 16, height: 1.6, color: Colors.white),

              h1: TextStyle(
                  fontSize: isMobile ? 18 : 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.8),
              h2: TextStyle(
                  fontSize: isMobile ? 16 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.7),
              h3: TextStyle(
                  fontSize: isMobile ? 14 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.6),

              strong: TextStyle(
                  fontSize: isMobile ? 10 : 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              em: TextStyle(
                  fontSize: isMobile ? 10 : 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.white70),

              blockquote: TextStyle(
                fontSize: isMobile ? 10 : 16,
                fontStyle: FontStyle.italic,
                color: Colors.white70,
                height: 1.6,
                backgroundColor: Colors.grey[850],
              ),

              code: TextStyle(
                fontSize: isMobile ? 8 : 15,
                fontFamily: 'monospace',
                backgroundColor: AppColors.sideNav,
                color: AppColors.submitButton,
                height: 1.6,
              ),

              listBullet: TextStyle(
                  fontSize: isMobile ? 10 : 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              listBulletPadding: EdgeInsets.only(left: 16, top: 4),

              tableHead: TextStyle(
                  fontSize: isMobile ? 10 : 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              tableBody: TextStyle(
                  fontSize: isMobile ? 10 : 16,
                  color: Colors.white,
                  height: 1.5),

              horizontalRuleDecoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2.0, color: Colors.white54),
                ),
              ),
              // code: TextStyle(
              //   fontFamily: GoogleFonts.firaCode().fontFamily,
              //   fontSize: 16,
              //   color: AppColors.whiteColor,
              // ),
            ),
          ),
        )
      ],
    );
  }
}
