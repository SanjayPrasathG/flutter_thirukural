import 'package:dio/dio.dart';
import 'package:flutter_thirukural/helpers/common_helpers.dart';
import 'package:flutter_thirukural/model/api_response_model.dart';
import 'package:flutter_thirukural/services/api_services/url_services.dart';

class ApiServices {
  static Dio dio = Dio(BaseOptions(
    baseUrl: UrlServices.BASE_URL,
    connectTimeout: Duration(minutes: 2),
    receiveTimeout: Duration(minutes: 2),
    responseType: ResponseType.json,
    contentType: 'application/json',
    headers: {
      'Accept': 'application/json',
    },
  ));

  static Future<ApiResponse> get({
    required Map<String, dynamic>? requestHeaders,
    required Map<String, dynamic>? requestParams,
    required String? endpoint,
  }) async {
    if (endpoint == null || endpoint.isEmpty) {
      return ApiResponse(
        status: false,
        message: 'No endpoint specified',
        response: [],
      );
    }

    try {
      logger.i(requestHeaders);

      var response = await dio.get(
        '${UrlServices.BASE_URL}/$endpoint',
        queryParameters: requestParams ?? {},
        options: Options(
          headers: {
            ...dio.options.headers,
            ...?requestHeaders,
          },
        ),
      );

      logger.i('RESPONSE during GET');
      logger.w(response.data);

      if (response.statusCode != null &&
          validStatusCodes.contains(response.statusCode)) {
        Map<String, dynamic> responseJson = response.data;
        if (responseJson.isEmpty) {
          return ApiResponse(
            status: false,
            message: response.statusMessage ?? 'No response data from server.',
            response: [],
          );
        }

        return ApiResponse.fromJson(responseJson);
      } else {
        return ApiResponse(
          status: false,
          message: response.statusMessage ?? 'Unexpected server response.',
          response: [],
        );
      }
    } on DioException catch (dioErr) {
      String errorMsg = 'Unknown Dio error occurred.';
      if (dioErr.type == DioExceptionType.connectionTimeout) {
        errorMsg = 'Connection timed out.';
      } else if (dioErr.type == DioExceptionType.receiveTimeout) {
        errorMsg = 'Server took too long to respond.';
      } else if (dioErr.type == DioExceptionType.badResponse) {
        errorMsg = 'Bad Request - ${dioErr.response?.data['message'] ?? 'Server turned 400 error'}';
      } else if (dioErr.type == DioExceptionType.cancel) {
        errorMsg = 'Request was cancelled.';
      } else if (dioErr.type == DioExceptionType.connectionError) {
        errorMsg = 'No internet connection or DNS failure.';
      } else if (dioErr.message != null) {
        errorMsg = dioErr.message!;
      }

      return ApiResponse(
        status: false,
        message: errorMsg,
        response: [],
      );
    } catch (e) {
      return ApiResponse(
        status: false,
        message: 'Unexpected error: ${e.toString()}',
        response: [],
      );
    }
  }
}
