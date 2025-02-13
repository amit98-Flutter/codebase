import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio});

  ///  Handles API response and returns `ResponseData`
 static ResponseData response(Response response) {
    try {
      switch (response.statusCode) {
        case 200:
        case 201:
          return ResponseData(data: jsonDecode(response.toString()), statusCode: response.statusCode!);
        case 400:
        case 401:
        case 403:
        case 404:
        case 409:
        case 500:
          return ResponseData(
            error: response.data['message'] ?? response.data['error']['message'] ?? "Unknown Error",
            statusCode: response.statusCode!,
          );
        default:
          return ResponseData(
            error: "Something went wrong",
            statusCode: response.statusCode ?? 500,
          );
      }
    } catch (e) {
      return ResponseData(error: "Error parsing response", statusCode: response.statusCode ?? 500);
    }
  }

  /// Handles API exceptions and returns readable error messages
  static String handleError(error) {
    String errorDescription = "Unexpected error occurred";

    if (error is DioException) {
      if (error.type == DioExceptionType.connectionError) {
        errorDescription = "No Internet Connection";
      } else if (error.type == DioExceptionType.connectionTimeout){
        errorDescription = "Connection timed out";
      } else if (error.type == DioExceptionType.sendTimeout){
        errorDescription = "Request time out";
      } else if (error.type == DioExceptionType.receiveTimeout){
        errorDescription = "Server took too long to respond";
      } else if (error.type == DioExceptionType.badResponse){
        errorDescription = "Server responded with an error";
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            errorDescription = "Bad Request";
            break;
          case 401:
            errorDescription = "Unauthorized";
            break;
          case 404:
            errorDescription = error.response!.data.toString();
            break;
          case 409:
            errorDescription = "Conflict";
            break;
          case 415:
            errorDescription = "Unsupported Media Type";
            break;
          case 500:
            errorDescription = "Internal Server Error";
            break;
          case 511:
            errorDescription = "Network Authentication Required";
            break;
          default:
            errorDescription = "Something went wrong";
        }
      } else {
        errorDescription = "Server unreachable";
      }
    } else if (error is SocketException) {
      errorDescription = "No Internet Connection";
    } else if (error is FormatException) {
      errorDescription = "Format error";
    }

    return errorDescription;
  }

}

/// Standardized API Response Model
class ResponseData {
  final dynamic data;
  final String? error;
  final num statusCode;

  ResponseData({this.data, this.error, required this.statusCode});
}
