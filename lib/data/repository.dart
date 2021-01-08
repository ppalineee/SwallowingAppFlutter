import 'dart:async';
import 'package:swallowing_app/data/local/datasources/post/post_datasource.dart';
import 'package:swallowing_app/data/network/apis/profile_api.dart';
import 'package:swallowing_app/data/sharedpref/shared_preference_helper.dart';
import 'package:swallowing_app/models/post/post.dart';
import 'package:swallowing_app/models/post/post_list.dart';
import 'package:sembast/sembast.dart';
import 'package:swallowing_app/models/profile.dart';
import 'local/constants/db_constants.dart';
import 'network/apis/login_api.dart';
import 'network/apis/posts/post_api.dart';

class Repository {
  // data source object
  final PostDataSource _postDataSource;

  // api objects
  final PostApi _postApi;
  final LoginApi _loginApi;
  final ProfileApi _profileApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._postApi, this._loginApi, this._profileApi, this._sharedPrefsHelper, this._postDataSource);

  // AuthToken:-----------------------------------------------------------------
  Future<void> loginPatient(username, password) async {
    try {
      var json = await _loginApi.loginPatient(username, password);
      _sharedPrefsHelper.saveAuthToken(json.token);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logoutPatient() async {
    _sharedPrefsHelper.removeAuthToken();
  }

  // Profile:-----------------------------------------------------------------
  Future<Profile> getPatientProfile() async {
    try {
      var token = await _sharedPrefsHelper.authToken;
      return await _profileApi.getPatientProfile(token);
    } catch (e) {
      rethrow;
    }
  }

  // Post: ---------------------------------------------------------------------
  Future<PostList> getPosts() async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use
    return await _postDataSource.count() > 0
        ? _postDataSource
            .getPostsFromDb()
            .then((postsList) => postsList)
            .catchError((error) => throw error)
        : _postApi.getPosts().then((postsList) {
            postsList.posts.forEach((post) {
              _postDataSource.insert(post);
            });

            return postsList;
          }).catchError((error) => throw error);
  }

  Future<List<Post>> findPostById(int id) {
    //creating filter
    List<Filter> filters = List();

    //check to see if dataLogsType is not null
    if (id != null) {
      Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
      filters.add(dataLogTypeFilter);
    }

    //making db call
    return _postDataSource
        .getAllSortedByFilter(filters: filters)
        .then((posts) => posts)
        .catchError((error) => throw error);
  }

  Future<int> insert(Post post) => _postDataSource
      .insert(post)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> update(Post post) => _postDataSource
      .update(post)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> delete(Post post) => _postDataSource
      .update(post)
      .then((id) => id)
      .catchError((error) => throw error);

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  Future<bool> get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  Future<String> get currentLanguage => _sharedPrefsHelper.currentLanguage;
}
