import 'dart:async';
import 'package:camera/camera.dart';
import 'package:swallowing_app/data/local/datasources/post/post_datasource.dart';
import 'package:swallowing_app/data/network/apis/assignment_api.dart';
import 'package:swallowing_app/data/network/apis/notification_api.dart';
import 'package:swallowing_app/data/network/apis/profile_api.dart';
import 'package:swallowing_app/data/network/apis/video_api.dart';
import 'package:swallowing_app/data/sharedpref/shared_preference_helper.dart';
import 'package:swallowing_app/models/ariticle.dart';
import 'package:swallowing_app/models/assignment.dart';
import 'package:swallowing_app/models/notification.dart';
import 'package:swallowing_app/models/post/post.dart';
import 'package:swallowing_app/models/post/post_list.dart';
import 'package:sembast/sembast.dart';
import 'package:swallowing_app/models/profile.dart';
import 'package:swallowing_app/models/video.dart';
import 'local/constants/db_constants.dart';
import 'network/apis/article_api.dart';
import 'network/apis/login_api.dart';
import 'network/apis/posts/post_api.dart';
import 'network/apis/test_api.dart';

class Repository {
  // data source object
  final PostDataSource _postDataSource;
  // api objects
  final PostApi _postApi;
  final LoginApi _loginApi;
  final ProfileApi _profileApi;
  final TestApi _testApi;
  final ArticleApi _articleApi;
  final VideoApi _videoApi;
  final AssignmentApi _assignmentApi;
  final NotificationApi _notificationApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._postApi, this._loginApi, this._profileApi, this._testApi,
      this._articleApi, this._videoApi, this._assignmentApi, this._notificationApi,
      this._sharedPrefsHelper, this._postDataSource);

  // AuthToken:-----------------------------------------------------------------
  Future<void> loginPatient(username, password) async {
    try {
      var json = await _loginApi.loginPatient(username, password);
      await _sharedPrefsHelper.saveAuthToken(json.token, json.type);
      Profile profile =  await _profileApi.getPatientProfile(json.token);
      await _sharedPrefsHelper.savePatientProfile(profile);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loginGuest() async {
    try {
      var json = await _loginApi.loginGuest();
      await _sharedPrefsHelper.saveAuthToken(json.token, json.type);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    _sharedPrefsHelper.removeAuthToken();
    _sharedPrefsHelper.removePatientProfile();
  }

  // Profile:-----------------------------------------------------------------
  Future<Profile> getPatientProfile() async {
    try {
      return await _sharedPrefsHelper.patientProfile;
    } catch (e) {
      rethrow;
    }
  }

  // Test:-----------------------------------------------------------------
  Future<bool> submitTestScore(List<int> score) async {
    try {
      String token = await _sharedPrefsHelper.authToken;
      bool submitSuccess = await _testApi.submitTestScore(token, score);
      if (submitSuccess) {
        await _sharedPrefsHelper.updatePatientScore(score);
      }
      return submitSuccess;
    } catch (e) {
      return false;
    }
  }

  // Article:-------------------------------------------------------------------
  Future<ArticleList> getArticleList() async {
    try {
      String token = await _sharedPrefsHelper.authToken;
      return await _articleApi.getArticleList(token);
    } catch(e) {
      rethrow;
    }
  }

  // Video:---------------------------------------------------------------------
  Future<VideoList> getVideoList() async {
    try {
      String token = await _sharedPrefsHelper.authToken;
      return await _videoApi.getVideoList(token);
    } catch(e) {
      rethrow;
    }
  }

  // Assignment:----------------------------------------------------------------
  Future<AssignmentList> getAssignmentList(String option) async {
    try {
      String token = await _sharedPrefsHelper.authToken;
      Profile profile = await _sharedPrefsHelper.patientProfile;
      return await _assignmentApi.getAssignmentList(token, profile.hnNumber, option);
    } catch(e) {
      rethrow;
    }
  }

  Future<bool> submitAssignment(String id, XFile videoFile) async {
    try {
      String token = await _sharedPrefsHelper.authToken;
      return await _assignmentApi.submitAssignment(token, id, videoFile);
    } catch(e) {
      return false;
    }
  }

  Future<bool> sendComment(String postId, String message) async {
    try {
      String token = await _sharedPrefsHelper.authToken;
      return await _assignmentApi.sendComment(token, postId, message);
    } catch(e) {
      return false;
    }
  }

  // Notification:--------------------------------------------------------------
  Future<NotificationList> getNotification() async {
    try {
      String token = await _sharedPrefsHelper.authToken;
      Profile profile = await _sharedPrefsHelper.patientProfile;
      return await _notificationApi.getNotification(token, profile.hnNumber);
    } catch(e) {
      rethrow;
    }
  }

  Future<bool> readNotification() async {
    try {
      String token = await _sharedPrefsHelper.authToken;
      Profile profile = await _sharedPrefsHelper.patientProfile;
      return await _notificationApi.readNotification(token, profile.hnNumber);
    } catch(e) {
      return false;
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
