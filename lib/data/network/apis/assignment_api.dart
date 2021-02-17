import 'dart:async';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:swallowing_app/data/network/constants/endpoints.dart';
import 'package:swallowing_app/data/network/dio_client.dart';
import 'package:swallowing_app/data/network/rest_client.dart';
import 'package:swallowing_app/models/assignment.dart';

class AssignmentApi {
  final RestClient _restClient;
  final DioClient _dioClient;

  AssignmentApi(this._restClient, this._dioClient);

  Future<AssignmentList> getAssignmentList(String token, String hnNumber, String option) async {
    try {
      Map<String, String> queryParams = {
        'hn': hnNumber,
        'option': option
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
      rethrow;
    }
  }

  Future<bool> submitAssignment(String token, String id, XFile videoFile) async {
    try {
      Map<String, String> queryParams = {
        'id': id,
        'option': '1'
      };
      FormData formData = new FormData.fromMap({
        'vdoFile': await MultipartFile.fromFile(
          videoFile.path,
          filename: '$id.mp4',
          contentType: MediaType('video','mp4')),
        'timestamp': DateTime.now().toString(),
      });

      return await _dioClient.put(
          Endpoints.submitAssignment,
          queryParameters: queryParams,
          options: Options(
            method: "PUT",
            headers: {
              'Authorization': token,
            },
          ),
          data: formData
      ).then((dynamic res) => (res['message'] == 'Update status Complete!') ? true : false);
    } catch (e) {
      return false;
    }
  }

  Future<bool> sendComment(String token, String postId, String message) async {
    try {
      String timestamp = DateTime.now().toString();
      Map<String, String> queryParams = {
        'id': postId
      };
      String queryString = Uri(queryParameters: queryParams).query;
      return await _restClient.put(
        Endpoints.sendComment + '?' + queryString,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
        body: jsonEncode(
            <String, String>{'message': message, 'timeStamp': timestamp})
      ).then((dynamic res) => (res['message'] == 'Comment Complete') ? true : false);
    } catch (e) {
      return false;
    }
  }
}