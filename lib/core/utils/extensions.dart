import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

extension StringExtensions on String {
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  bool get isValidEmail =>
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
          .hasMatch(this);
}

extension ContextExtensions on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get bottomPadding => MediaQuery.of(this).padding.bottom;
  double get topPadding => MediaQuery.of(this).padding.top;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}

extension TimestampExtensions on Timestamp {
  DateTime toDateTime() => toDate();
}

extension DateTimeExtensions on DateTime {
  String get timeAgo {
    final diff = DateTime.now().difference(this);
    if (diff.inSeconds < 60) return '${diff.inSeconds}s ago';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    return '${diff.inHours}h ago';
  }

  String get formatted =>
      '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year  ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}

extension DoubleExtensions on double {
  String get formatted => toStringAsFixed(0);
  String get formattedWithDecimal => toStringAsFixed(1);
}