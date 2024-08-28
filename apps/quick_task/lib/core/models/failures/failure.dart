import 'package:equatable/equatable.dart';
import 'package:quick_task/generated/l10n.dart';

abstract class Failure extends Equatable implements Exception {
  final int key;
  final String title;
  final String message;
  final dynamic data;

  const Failure({
    required this.key,
    required this.title,
    required this.message,
    this.data,
  });

  @override
  List<Object> get props => [
        key,
        title,
        message,
        if (data != null) data,
      ];
}

class InternetFailure extends Failure {
  InternetFailure()
      : super(
          key: 1001,
          title: QuickTaskL10n.current.no_internet_connection,
          message: '',
        );
}

class UnknownFailure extends Failure {
  final String messageData;

  const UnknownFailure({
    this.messageData = '',
    super.data,
  }) : super(
          key: -1,
          title: 'unknown_error',
          message: messageData,
        );
}
