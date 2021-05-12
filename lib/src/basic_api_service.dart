abstract class BasicApiService {
  /// POST Dio Method
  Future<T> dioPost<T>(
    String url, {
    dynamic data,
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  });

  /// GET Dio Method
  Future<T> dioGet<T>(
    String url, {
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  });

  /// DOWNLOAD Dio Method
  Future<T> dioDownload<T>(
    String url,
    String savePath,
  );
}
