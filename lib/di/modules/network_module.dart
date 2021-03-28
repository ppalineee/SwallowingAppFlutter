import 'package:swallowing_app/data/network/apis/article_api.dart';
import 'package:swallowing_app/data/network/apis/assignment_api.dart';
import 'package:swallowing_app/data/network/apis/login_api.dart';
import 'package:swallowing_app/data/network/apis/notification_api.dart';
import 'package:swallowing_app/data/network/apis/posts/post_api.dart';
import 'package:swallowing_app/data/network/apis/profile_api.dart';
import 'package:swallowing_app/data/network/apis/test_api.dart';
import 'package:swallowing_app/data/network/apis/video_api.dart';
import 'package:swallowing_app/data/network/constants/endpoints.dart';
import 'package:swallowing_app/data/network/dio_client.dart';
import 'package:swallowing_app/data/network/rest_client.dart';
import 'package:swallowing_app/data/sharedpref/constants/preferences.dart';
import 'package:swallowing_app/data/sharedpref/shared_preference_helper.dart';
import 'package:swallowing_app/di/modules/preference_module.dart';
import 'package:dio/dio.dart';
import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
class NetworkModule extends PreferenceModule {
  // ignore: non_constant_identifier_names
  final String TAG = "NetworkModule";

  // DI Providers:--------------------------------------------------------------
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  Dio provideDio(SharedPreferenceHelper sharedPrefHelper) {
    final dio = Dio();

    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (Options options) async {
            // getting shared pref instance
            var prefs = await SharedPreferences.getInstance();

            // getting token
            var token = prefs.getString(Preferences.auth_token);

            if (token != null) {
              options.headers.putIfAbsent('Authorization', () => token);
            } else {
              print('Auth token is null');
            }
          },
        ),
      );

    return dio;
  }

  /// A singleton dio_client provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  DioClient provideDioClient(Dio dio) => DioClient(dio);

  /// A singleton dio_client provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  RestClient provideRestClient() => RestClient();

  // Api Providers:-------------------------------------------------------------
  // Define all your api providers here
  /// A singleton post_api provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  PostApi providePostApi(DioClient dioClient, RestClient restClient) =>
      PostApi(dioClient, restClient);

  @provide
  @singleton
  LoginApi provideLoginApi(RestClient restClient) =>
      LoginApi(restClient);

  @provide
  @singleton
  ProfileApi provideProfileApi(RestClient restClient) =>
      ProfileApi(restClient);

  @provide
  @singleton
  TestApi provideTestApi(RestClient restClient) =>
      TestApi(restClient);

  @provide
  @singleton
  ArticleApi provideArticleApi(RestClient restClient) =>
      ArticleApi(restClient);

  @provide
  @singleton
  VideoApi provideVideoApi(RestClient restClient) =>
      VideoApi(restClient);

  @provide
  @singleton
  AssignmentApi provideAssignmentApi(RestClient restClient, DioClient dioClient) =>
      AssignmentApi(restClient, dioClient);

  @provide
  @singleton
  NotificationApi provideNotificationApi(RestClient restClient, DioClient dioClient) =>
      NotificationApi(restClient);
  // Api Providers End:---------------------------------------------------------

}
