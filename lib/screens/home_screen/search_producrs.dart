import 'package:flutter/material.dart';

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
                  hintText: "Search Products...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: AppTheme.textSecondary,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppTheme.textSecondary,
                  ),
                  suffixIcon: Icon(Icons.tune,
                      color: AppTheme.primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
