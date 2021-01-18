import 'dart:async';
import 'package:swallowing_app/data/network/constants/endpoints.dart';
import 'package:swallowing_app/data/network/rest_client.dart';
import 'package:swallowing_app/models/video.dart';

class VideoApi {
  final RestClient _restClient;

  VideoApi(this._restClient);

  Future<VideoList> getVideoList(String token) async {
    try {
      return await _restClient.get(
        Endpoints.getVideos,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      ).then((dynamic res) => VideoList.fromJson(res));
    } catch (e) {
      rethrow;
    }
  }
}