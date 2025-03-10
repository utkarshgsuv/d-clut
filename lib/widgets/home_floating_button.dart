import 'package:ai_rag_search_engine/services/chat_web_service.dart';
import 'package:ai_rag_search_engine/theme/colors';
import 'package:flutter/material.dart';
import 'package:ai_rag_search_engine/pages/about_d.dart';

class HomeFloatingButton extends StatelessWidget {
  const HomeFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * 0.015, 
      top: MediaQuery.of(context).size.height * 0.875, 
      child: GestureDetector(
        onTap: () {
          ChatWebService().disconnect();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AboutD(), 
            ),
          );
        },
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(48, 179, 81, 51),
                  AppColors.sideNav
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              color: AppColors.submitButton, 
              borderRadius: BorderRadius.circular(50)),
          child: Icon(
            Icons.home,
            color: AppColors.whiteColor,
            size: 28,
          ),
        ),
      ),
    );
  }
}
