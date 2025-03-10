import 'package:ai_rag_search_engine/services/chat_web_service.dart';
import 'package:ai_rag_search_engine/theme/colors';
import 'package:ai_rag_search_engine/widgets/answer_section.dart';
import 'package:ai_rag_search_engine/widgets/home_floating_button.dart';
import 'package:ai_rag_search_engine/widgets/side_bar.dart';
import 'package:ai_rag_search_engine/widgets/sources_section.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatefulWidget {
  final String question;
  const ChatPage({
    super.key,
    required this.question,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController followUpController = TextEditingController();
  @override
  void dispose() {
    
    super.dispose();
    followUpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;
    return Stack(children: [
      Scaffold(
        body: Row(
          children: [
            if (!isMobile) SideBar(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: isMobile ? 20 : 50.0, right: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //title -> query
                                  ShaderMask(
                                    shaderCallback: (bounds) => LinearGradient(
                                      colors: [
                                        Colors.pink,
                                        AppColors.submitButton
                                      ],
                                    ).createShader(bounds),
                                    child: Text(
                                      widget.question,
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  //sources -> url
                                  SourcesSection(),
                                  //answers
                                  SizedBox(
                                    height: 20,
                                  ),
                                  AnswerSection(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      width: 800,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.searchBarBorder,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: followUpController,
                              decoration: InputDecoration(
                                hintText: 'Ask d-Clut....',
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
                          Row(
                            children: [
                              SizedBox(),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  ChatWebService()
                                      .chat(followUpController.text.trim());

                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => ChatPage(
                                        question:
                                            followUpController.text.trim(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.all(7),
                                  padding: EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: AppColors.submitButton,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            //images section
            // Placeholder(
            //   strokeWidth: 0,
            //   color: AppColors.background,
            // )
          ],
        ),
      ),
      if (isMobile) HomeFloatingButton(),
    ]);
  }
}
