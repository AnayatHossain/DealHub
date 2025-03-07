import 'package:flutter/material.dart';

class UseerProfileData extends StatelessWidget {
  const UseerProfileData({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white.withOpacity(0.2),
          child: Icon(
            Icons.location_on_outlined,
            color: Colors.white,
            size: 20,
          ),
        ),
        SizedBox(width: 12),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Deliver to",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            Text(
              "Mirpur 1, Bangladesh",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
