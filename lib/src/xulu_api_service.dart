import 'package:dio/dio.dart' show Response, ResponseType;

abstract class XuluApiService {
  /// POST Dio Method
  Future<Response> dioPost(
    String url, {
    dynamic data,
    String token,
    responseType: ResponseType.json,
    Map<String, dynamic> headers,
    Map<String, dynamic> query,
  });

  /// GET Dio Method
  Future<Response> dioGet(
    String url, {
    String token,
    responseType: ResponseType.json,
    Map<String, dynamic> headers,
    Map<String, dynamic> query,
  });

  /// DOWNLOAD Dio Method
  Future<Response> dioDownload(
    String url,
    String savePath,
  );
}
