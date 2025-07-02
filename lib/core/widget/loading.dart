import 'package:flutter/material.dart';

class Loading {
  static bool isLoading = false;

  static showLoading(BuildContext context) {
    isLoading = true;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          title: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  static hideLoading(BuildContext context) {
    if (isLoading) {
      Navigator.pop(context);
      isLoading = false;
    }
  }
}
