// import 'dart:async';
// import '../logging/app_logger.dart';

// mixin StreamManager {
//   final Map<String, StreamSubscription> _subscriptions = {};

//   void listenTo<T>(
//     String key,
//     Stream<T> stream,
//     void Function(T data) onData, {
//     void Function(Object error, StackTrace stack)? onError,
//     void Function()? onDone,
//   }) {
//     cancelSubscription(key);
//     _subscriptions[key] = stream.listen(
//       onData,
//       onError: (Object e, StackTrace st) {
//         AppLogger.e('Stream [$key] error', e, st);
//         onError?.call(e, st);
//       },
//       onDone: () {
//         AppLogger.d('Stream [$key] done');
//         onDone?.call();
//       },
//       cancelOnError: false,
//     );
//     AppLogger.d('Stream [$key] subscribed');
//   }

//   void cancelSubscription(String key) {
//     final sub = _subscriptions.remove(key);
//     if (sub != null) {
//       sub.cancel();
//       AppLogger.d('Stream [$key] cancelled');
//     }
//   }

//   void cancelAll() {
//     for (final entry in _subscriptions.entries) {
//       entry.value.cancel();
//       AppLogger.d('Stream [${entry.key}] cancelled (cancelAll)');
//     }
//     _subscriptions.clear();
//   }

//   bool isListening(String key) => _subscriptions.containsKey(key);
// }