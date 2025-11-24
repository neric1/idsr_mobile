import 'base_response.dart';

class ErrorResponse  {
  final String errorMessage;
  final int errorCode;

  ErrorResponse(this.errorCode, this.errorMessage);
}