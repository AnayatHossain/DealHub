import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData prefixIcon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon;

  const CustomTextField(
      {super.key,
      required this.label,
      required this.prefixIcon,
      this.isPassword = false,
      this.keyboardType,
      this.validator,
      this.controller,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        validator: validator,
        style: TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 14,
          ),
          prefixIcon: Icon(prefixIcon, color: AppTheme.primaryColor),
          suffixIcon: suffixIcon ??
              (isPassword
                  ? IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.visibility_outlined),
                      color: AppTheme.primaryColor,
                    )
                  : null),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: AppTheme.textSecondary.withOpacity(0.1), width: 1),
          ),
        ),
      ),
    );
  }
}
