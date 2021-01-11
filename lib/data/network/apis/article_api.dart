import 'dart:async';
import 'package:swallowing_app/data/network/constants/endpoints.dart';
import 'package:swallowing_app/data/network/rest_client.dart';
import 'package:swallowing_app/models/ariticle.dart';

class ArticleApi {
  final RestClient _restClient;

  ArticleApi(this._restClient);

  Future<ArticleList> getArticleList(String token) async {
    try {
      return await _restClient.get(
        Endpoints.getArticles,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      ).then((dynamic res) => ArticleList.fromJson(res));
    } catch (e) {
      rethrow;
    }
  }
}