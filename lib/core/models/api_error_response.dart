/*
  Class to decode error in api response
 */
class ApiAlert {
  String message;
  String code;
  int statusCode;

  ApiAlert();

  ApiAlert.fromResponse(Map<String, Object> response, int statusCode, [bool identityResponse = false]) {
    this.message = response['message'];
    this.code = response['code'];
    this.statusCode = statusCode;
  }

}