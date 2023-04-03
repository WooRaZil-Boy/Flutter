import 'package:equatable/equatable.dart';

// firebase exception과 관련이 있다.
class CustomError extends Equatable {
  final String code;
  final String message;
  final String plugin;

  CustomError({
    this.code = '',
    this.message = '',
    this.plugin = '',
  });

  @override
  List<Object> get props => [code, message, plugin];

  @override
  String toString() =>
      'CustomError(code: $code, message: $message, plugin: $plugin)';
}
