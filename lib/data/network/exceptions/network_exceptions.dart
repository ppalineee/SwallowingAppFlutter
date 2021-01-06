class NetworkException implements Exception {
  String message;
  int statusCode;

  NetworkException({this.message, this.statusCode});
}

