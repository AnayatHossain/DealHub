import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

Widget buildMenuItem({
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
  required Color color,
  bool isDestructive = false,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: isDestructive
                  ? AppTheme.error.withOpacity(0.1)
                  : color.withOpacity(0.1),
            ),
            child: Icon(
              icon,
              color: isDestructive ? AppTheme.error : color,
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color:
                    isDestructive ? AppTheme.error : AppTheme.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: AppTheme.textSecondary,
            size: 20,
          ),
        ],
      ),
    ),
  );
}