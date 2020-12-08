import 'api_error_response.dart';

class ApiException implements Exception {
  final ApiAlert error;

  ApiException(this.error);

  @override
  String toString() {
    return error ?? error.toString();
  }
}
