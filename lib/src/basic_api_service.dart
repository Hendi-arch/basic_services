abstract class BasicApiService {
  /// POST Dio Method
  Future<dynamic> dioPost(
    String url, {
    dynamic data,
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  });

  /// GET Dio Method
  Future<dynamic> dioGet(
    String url, {
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  });

  /// DOWNLOAD Dio Method
  Future<dynamic> dioDownload(
    String url,
    String savePath,
  );
}
