import 'dart:async';
import 'package:swallowing_app/data/network/constants/endpoints.dart';
import 'package:swallowing_app/data/network/rest_client.dart';
import 'package:swallowing_app/models/profile.dart';

class ProfileApi {
  final RestClient _restClient;

  ProfileApi(this._restClient);

  Future<Profile> getPatientProfile(String token) async {
    try {
      return await _restClient.get(
        Endpoints.profile,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      ).then((dynamic res) => Profile.fromJSON(res));
    } catch (e) {
      rethrow;
    }
  }
}