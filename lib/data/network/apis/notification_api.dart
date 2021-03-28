import 'dart:async';
import 'package:swallowing_app/data/network/constants/endpoints.dart';
import 'package:swallowing_app/data/network/rest_client.dart';
import 'package:swallowing_app/models/notification.dart';

class NotificationApi {
  final RestClient _restClient;

  NotificationApi(this._restClient);

  Future<NotificationList> getNotification(String token, String hnNumber) async {
    try {
      Map<String, String> queryParams = {
        'hn': hnNumber,
      };
      String queryString = Uri(queryParameters: queryParams).query;
      return await _restClient.get(
        Endpoints.getNotification + '?' + queryString,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      ).then((dynamic res) => NotificationList.fromJson(res));
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> readNotification(String token, String hnNumber) async {
    try {
      Map<String, String> queryParams = {
        'hn': hnNumber,
      };
      String queryString = Uri(queryParameters: queryParams).query;
      return await _restClient.get(
        Endpoints.getNotification + '?' + queryString,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      ).then((dynamic res) => (res['message'] == 'All Notification read') ? true : false);
    } catch (e) {
      return false;
    }
  }
}