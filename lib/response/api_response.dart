import 'package:my_clients_by_anduril/helpers/api_error.dart';

class ApiResponse {

  ApiResponse.success({this.result}) {
    success = true;
  }

  ApiResponse.fail({this.error}) {
    success = false;
  }

  bool success;
  dynamic result;
  ApiError error;

}