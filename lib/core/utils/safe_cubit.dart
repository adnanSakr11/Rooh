// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'stream_manager.dart';
// import '../logging/app_logger.dart';

// abstract class SafeCubit<S> extends Cubit<S> with StreamManager {
//   SafeCubit(super.initialState);

//   bool _closed = false;

//   @override
//   void emit(S state) {
//     if (_closed) {
//       AppLogger.w('$runtimeType: emit called after close — ignored');
//       return;
//     }
//     super.emit(state);
//   }

//   void safeEmit(S state) => emit(state);

//   @override
//   Future<void> close() {
//     _closed = true;
//     cancelAll();
//     return super.close();
//   }
// }