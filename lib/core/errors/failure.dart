import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  final Object? cause;
  final StackTrace? stackTrace;
  const Failure({required this.message, this.cause, this.stackTrace});

  @override
  List<Object?> get props => [message];
}
