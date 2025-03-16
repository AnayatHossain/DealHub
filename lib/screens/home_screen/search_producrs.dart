import 'package:deal_hub/screens/home_screen/home_search_screen.dart';
import 'package:deal_hub/screens/home_screen/search_filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme.dart';

class SearchProducts extends StatelessWidget {
  const SearchProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                onSubmitted: (value) {
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen());
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                  hintText: "Search Products...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: AppTheme.textSecondary,
                  ),
                  prefixIcon: IconButton(
                    onPressed: () {
                      Get.to(()=>HomeSearchScreen());
                    },
                    icon: Icon(
                      Icons.search,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      showFilterBottomSheet(context);
                    },
                    icon: Icon(
                      Icons.tune,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
