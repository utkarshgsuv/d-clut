import 'package:ai_rag_search_engine/theme/colors';
import 'package:ai_rag_search_engine/widgets/home_floating_button.dart';
import 'package:ai_rag_search_engine/widgets/side_bar.dart';
import 'package:ai_rag_search_engine/widgets/yt_url_section.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YtUrl extends StatelessWidget {
  const YtUrl({super.key});

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
    return Stack(
      children: [
        Scaffold(
          body: Row(
            children: [
              if (!isMobile) SideBar(),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.only(left: isMobile ? 20.0 : 50, right: 20),
                  child: Column(
                    children: [
                      //search box
                      Expanded(
                        child: YtUrlSection(), // search section for yt links
                      ),

                      //footer
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: InkWell(
                                  onTap: () => _launchURL(
                                      'https://www.linkedin.com/in/utkarshmaheshwari'),
                                  child: Text(
                                    'Contact us!',
                                    style: TextStyle(
                                      color: AppColors.textGrey,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        if (isMobile) HomeFloatingButton()
      ],
    );
  }
}
