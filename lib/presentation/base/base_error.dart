
/// The operation was not allowed by the current state of the object.
///
/// This is a generic error used for a variety of different erroneous
/// actions. The message should be descriptive.
class BaseError implements Exception {
  BaseError({
    this.message,
    this.type = BaseErrorType.DEFAULT,
    this.error,
  });

  /// Error descriptions.
  String message;

  BaseErrorType type;


  dynamic error;

  String toString() => message;

}

class BaseErrorType<int> extends Enum<int> {
  const BaseErrorType(int value) : super(value);
  static const BaseErrorType DEFAULT = const BaseErrorType(1);
  static const BaseErrorType UNEXPECTED = const BaseErrorType(2);
  static const BaseErrorType SERVER_TIMEOUT = const BaseErrorType(3);
  static const BaseErrorType INVALID_RESPONSE = const BaseErrorType(4);
  static const BaseErrorType SERVER_MESSAGE = const BaseErrorType(5);
}

abstract class Enum<T> {
  final T value;

  const Enum(this.value);
}
