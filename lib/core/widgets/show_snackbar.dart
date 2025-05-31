import 'package:flutter/material.dart';
import 'package:salla_commerce_app/core/utils/app_styles.dart';

void showsnackbar(
  BuildContext context, {
  required String message,
  required Color color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(
        message,
        style: AppStyles.style15.copyWith(color: Colors.white),
      ),
      backgroundColor: color,
    ),
  );
}
