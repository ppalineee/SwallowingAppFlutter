import 'package:dio/dio.dart';
import 'package:swallowing_app/data/network/exceptions/network_exceptions.dart';

class DioClient {

  // dio instance
  final Dio _dio;

  // injecting dio instance
  DioClient(this._dio);

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
      String uri, {
        Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
        ProgressCallback onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
      String uri, {
        data,
        Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
        ProgressCallback onSendProgress,
        ProgressCallback onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<dynamic> put(
      String uri, {
        data,
        Map<String, dynamic> queryParameters,
        Options options,
      }) async {
    try {
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      final int statusCode = response.statusCode;
      print('statusCode: $statusCode');
      if (statusCode < 200 || statusCode > 400) {
        throw NetworkException(
            message: "Error fetching data from server", statusCode: statusCode);
      } if (statusCode == 400) {
        throw NetworkException(
            message: response.data, statusCode: statusCode);
      }

      Map responseBody = response.data;
      return responseBody;
    } catch (e) {
      throw e;
    }
  }
}
