import 'dart:async';
import 'dart:convert';
import 'package:swallowing_app/data/network/constants/endpoints.dart';
import 'package:swallowing_app/data/network/exceptions/network_exceptions.dart';
import 'package:swallowing_app/data/network/rest_client.dart';
import 'package:swallowing_app/models/jwt_token.dart';

class LoginApi {
  final RestClient _restClient;

  LoginApi(this._restClient);

  Future<JWTToken> loginPatient(username, password) async {
    return await _restClient.post(
        Endpoints.loginPatient,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'username': username, 'password': password})
    ).then((dynamic res) => JWTToken.fromJSON(res))
        .catchError((error) => throw NetworkException(message: error));
  }
}