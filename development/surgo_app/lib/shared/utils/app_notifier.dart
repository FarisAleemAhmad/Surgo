// basic imports
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

// simple class for all user facing messages - centralized
class AppNotifier {
  // get class for message
  static String getMessage(Object? err, {bool isSuccess = false}) {
    if (isSuccess && (err is String)) {
      return err;
    }

    String message = "Something went wrong. Please try again.";

    if (err is DioException) {
      final status = err.response?.statusCode;

      switch (status) {
        case 200:
          message = "Success";
          break;
        case 201:
          message = "Account created successfully.";
          break;
        case 204:
          message = "Deleted successfully.";
          break;
        case 400:
          message = "Invalid request. Please check your details.";
          break;
        case 401:
          message = "Unauthorized. Please log in again.";
          break;
        case 403:
          message = "You are not allowed to perform this action.";
          break;
        case 404:
          message = "Resource not found.";
          break;
        case 409:
          message = "This email is already registered.";
          break;
        case 422:
          message = "Invalid input. Please try again.";
          break;
        case 429:
          message = "Too many attempts. Try again later.";
          break;
        case 500:
        case 503:
          message = "Server error. Please try again later.";
          break;
        default:
          message = "Unexpected error occurred.";
      }
    } else if (isSuccess && (err is String)) {
      // explicit custom success
      message = err;
    } else if (err is String) {
      // fallback manual string
      message = err;
    }

    return message;
  }

  // Show an error Flushbar
  static void showError(BuildContext context, Object err) {
    final message = getMessage(err);
    _showFlushbar(context, message, Colors.redAccent);
  }

  // Show a success Flushbar
  static void showSuccess(BuildContext context, String message) {
    final msg = getMessage(message, isSuccess: true);
    _showFlushbar(context, msg, Colors.green);
  }

  /// Internal helper for displaying Flushbar
  static void _showFlushbar(BuildContext context, String message, Color color) {
    Flushbar(
      messageText: Row(
        mainAxisSize: MainAxisSize.min, // row usage to shrink to text size
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      backgroundColor: color,
      margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
      borderRadius: BorderRadius.circular(12),
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ).show(context);
  }
}
