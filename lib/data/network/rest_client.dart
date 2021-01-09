import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'exceptions/network_exceptions.dart';

class RestClient {

  // instantiate json decoder for json serialization
  final JsonDecoder _decoder = JsonDecoder();

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(String url, {Map headers}) {
    return http.get(url, headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      print('status code: $statusCode');

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw NetworkException(
            message: "Error fetching data from server", statusCode: statusCode);
      } if (statusCode == 400) {
        throw NetworkException(
            message: response.body, statusCode: statusCode);
      }

      return _decoder.convert(res);
    });
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(String url, {Map headers, body, encoding}) {
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      print('status code: $statusCode');

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw NetworkException(
            message: "Error fetching data from server", statusCode: statusCode);
      } if (statusCode == 400) {
        throw NetworkException(
            message: response.body, statusCode: statusCode);
      }

      return _decoder.convert(res);
    });
  }
}
