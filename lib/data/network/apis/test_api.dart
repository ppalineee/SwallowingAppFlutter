import 'dart:async';
import 'dart:convert';
import 'package:swallowing_app/data/network/constants/endpoints.dart';
import 'package:swallowing_app/data/network/rest_client.dart';

class TestApi {
  final RestClient _restClient;

  TestApi(this._restClient);

  Future<bool> submitTestScore(String token, List<int> score) async {
    try {
      return await _restClient.post(
        Endpoints.submitScore,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token
        },
        body: jsonEncode(
            <String, dynamic>{'score': score})
      ).then((dynamic res) => true);
    } catch (e) {
      return false;
    }
  }
}