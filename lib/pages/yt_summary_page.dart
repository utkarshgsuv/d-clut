import 'package:ai_rag_search_engine/widgets/home_floating_button.dart';
import 'package:ai_rag_search_engine/widgets/side_bar.dart';
import 'package:ai_rag_search_engine/widgets/yt_summary.dart';
import 'package:flutter/material.dart';

class YtSummaryPage extends StatelessWidget {
  final String url;
  const YtSummaryPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;
    return Stack(
      children: [
        Scaffold(
          body: Row(
            children: [
              if (!isMobile) SideBar(),
              Expanded(
                child: YtSummary(
                  url: url,
                ),
              ),
            ],
          ),
        ),
        if (isMobile) HomeFloatingButton()
      ],
    );
  }
}
