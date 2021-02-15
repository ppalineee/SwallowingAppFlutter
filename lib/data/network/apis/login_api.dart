import 'dart:async';
import 'dart:convert';
import 'package:swallowing_app/data/network/constants/endpoints.dart';
import 'package:swallowing_app/data/network/rest_client.dart';
import 'package:swallowing_app/models/jwt_token.dart';

class LoginApi {
  final RestClient _restClient;

  LoginApi(this._restClient);

  Future<JWTToken> loginPatient(username, password) async {
    try {
      return await _restClient.post(
          Endpoints.loginPatient,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{'username': username, 'password': password})
      ).then((dynamic res) => JWTToken.fromJSON(res));
    } catch (e) {
      rethrow;
    }
  }

  Future<JWTToken> loginGuest() async {
    try {
      return await _restClient.get(
          Endpoints.loginGuest,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }
      ).then((dynamic res) => JWTToken.fromJSON(res));
    } catch (e) {
      rethrow;
    }
  }
}