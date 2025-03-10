import 'dart:async';

import 'package:ai_rag_search_engine/services/chat_web_service.dart';
import 'package:ai_rag_search_engine/theme/colors';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SourcesSection extends StatefulWidget {
  const SourcesSection({super.key});

  @override
  State<SourcesSection> createState() => _SourcesSectionState();
}

class _SourcesSectionState extends State<SourcesSection> {
  bool isLoading = true;
  //mock data
  List searchResults = [
    {
      'title': 'Ind vs Aus Live Score 4th Test',
      'url':
          'https://www.moneycontrol.com/sports/cricket/ind-vs-aus-live-score-4th-test',
    },
    {
      'title': 'Ind vs Aus Live Boxing Day Test',
      'url':
          'https://timesofindia.indiatimes.com/sports/cricket/india-vs-australia-live-boxing-day-test',
    },
    {
      'title': 'Ind vs Aus - 4 Australian Batters Score Half Centuries',
      'url':
          'https://economictimes.indiatimes.com/news/sports/ind-vs-aus-four-australian-batters-score-half-centuries',
    },
  ];
  StreamSubscription? _subscription;
  @override
  void initState() {
   
    super.initState();
    _subscription = ChatWebService().searchResultStream.listen(
      (data) {
        setState(() {
          searchResults = (data['data']);
          isLoading = false;
        });
      },
    );
  }

  @override
  void dispose() {
    
    _subscription?.cancel();
    super.dispose();
  }

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.source_outlined,
              color: Colors.white70,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Sources',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Skeletonizer(
          effect: ShimmerEffect(
            baseColor: AppColors.sideNav,
            highlightColor: AppColors.submitButton,
            duration: Duration(seconds: 1),
          ),
          enabled: isLoading,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: searchResults.map((res) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => _launchURL(res['url']),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      width: 150,
                      decoration: BoxDecoration(
                        color: AppColors.sideNav,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            res['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            res['url'],
                            style: TextStyle(
                              color: AppColors.submitButton,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}
