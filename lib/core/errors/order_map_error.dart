import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

String orderMapError(Object error, {required String fallback}) {
    if (error is TimeoutException) {
      return 'الاتصال ضعيف، اتأكد من الإنترنت وحاول مرة أخرى';
    }
    if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return 'مش مسموح بتنفيذ العملية دي';
        case 'unavailable':
        case 'deadline-exceeded':
          return 'مشكلة في الاتصال بالإنترنت';
      }
    }
    return fallback;
  }