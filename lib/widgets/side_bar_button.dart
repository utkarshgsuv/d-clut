import 'package:ai_rag_search_engine/theme/colors';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideBarButton extends StatelessWidget {
  final bool isCollapsed;
  final String text;
  final IconData icon;

  const SideBarButton({
    super.key,
    required this.isCollapsed,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          child: Icon(
            icon,
            color: AppColors.iconGrey,
            size: 22,
          ),
        ),
        if (!isCollapsed)
          FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 150), () => true),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(); // Delay text rendering
              }
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.firaCode().fontFamily,
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
