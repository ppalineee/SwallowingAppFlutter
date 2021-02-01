import 'dart:async';
import 'package:swallowing_app/data/network/constants/endpoints.dart';
import 'package:swallowing_app/data/network/rest_client.dart';
import 'package:swallowing_app/models/assignment.dart';

class AssignmentApi {
  final RestClient _restClient;

  AssignmentApi(this._restClient);

  Future<AssignmentList> getAssignmentList(String token, String hnNumber) async {
    try {
      Map<String, String> queryParams = {
        'hn': hnNumber,
        'option': '0'
      };
      String queryString = Uri(queryParameters: queryParams).query;
      return await _restClient.get(
        Endpoints.getAssignments + '?' + queryString,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      ).then((dynamic res) => AssignmentList.fromJson(res));
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }
}