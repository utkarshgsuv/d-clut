import 'dart:convert';

import 'package:ai_rag_search_engine/theme/colors';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class YtSummary extends StatefulWidget {
  final String url;
  const YtSummary({super.key, required this.url});

  @override
  State<YtSummary> createState() => _YtSummaryState();
}

class _YtSummaryState extends State<YtSummary> {
  late Future<String> summaryFuture;

  final String temp = ''' # 🏏 Cricket Live Updates

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

  String fixEncoding(String text) {
    return text
        .replaceAll("â", "'") // Fix apostrophes
        .replaceAll("â€“", "-") // Fix dashes
        .replaceAll("â€œ", '"') // Fix left quote
        .replaceAll("â€", '"'); // Fix right quote
  }

  Future<String> getSummary() async {
    try {
      final res = Uri.parse("http://localhost:8000/summarise");
      print("Sending request to: $res");
      final response = await http.post(
        res,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {'query': widget.url},
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse[
            'summary']; // This contains your structured summary.
      } else {
        throw 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      print("Exception: ${e.toString()}"); // Debugging line
      throw 'Exception: ${e.toString()}';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    summaryFuture = getSummary();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;
    return FutureBuilder(
      future: summaryFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator.adaptive(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'd-Clut AI is preparing notes for you........',
                    style: TextStyle(
                        fontFamily: GoogleFonts.firaCode().fontFamily,
                        color: AppColors.submitButton),
                  ),
                )
              ],
            ),
          );
        }

        if (snapshot.hasError || snapshot.data == null) {
          return Center(
            child: Text(
              'Something went wrong. Please try again.',
              style: const TextStyle(color: AppColors.textGrey),
            ),
          );
        }

        final ans = snapshot.data!;

        return Padding(
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //title
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.pink, AppColors.submitButton],
                ).createShader(bounds),
                child: Text(
                  "Your YouTube Video, Summarized Like Magic!",
                  style: TextStyle(
                    fontFamily: GoogleFonts.firaCode().fontFamily,
                    fontSize: isMobile ? 15 : 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'd-Clut',
                style: TextStyle(
                  fontFamily: GoogleFonts.firaCode().fontFamily,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Markdown(
                      selectable: true,
                      data: fixEncoding(ans),
                      shrinkWrap: true,
                      styleSheet: MarkdownStyleSheet(
                        pPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        p: TextStyle(
                            fontSize: 16, height: 1.6, color: Colors.white),

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
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
