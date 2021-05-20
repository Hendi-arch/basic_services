import '../basic_services.dart';
import 'service_locator.dart';

enum BasicErrorType {
  /// It occurs when url is opened timeout.
  connectTimeout,

  /// It occurs when url is sent timeout.
  sendTimeout,

  ///It occurs when receiving timeout.
  receiveTimeout,

  /// When the server response, but with a incorrect status, such as 404, 503...
  response,

  /// When the request is cancelled, service will throw a error with this type.
  cancel,

  /// Default error type, Some other Error. In this case, you can
  /// use the BasicServiceErrorException.error if it is not null.
  other,
}

class BasicServiceErrorException implements Exception {
  BasicServiceErrorException({
    required this.requestOptions,
    this.response,
    this.type = BasicErrorType.other,
    this.error,
  });

  /// Request info.
  dynamic requestOptions;

  /// Response info, it may be `null` if the request can't reach to
  /// the http server, for example, occurring a dns error, network is not available.
  dynamic response;

  BasicErrorType type;

  /// The original error/exception object; It's usually not null when `type`
  /// is BasicErrorType.DEFAULT
  dynamic error;

  String get message => (error?.toString() ?? '');

  @override
  String toString() {
    var msg = 'BasicServiceErrorException [$type]: $message';
    return msg;
  }
}

mixin ExceptionServiceMixin {
  final _bottomSheetService = dependenciesLocator<BottomSheetService>();

  void onHandlingError(error, backEndMessage, Object? key, {Function? errorCallback}) {
    print('Key event is : $key');
    print('[HendiDevException] ERROR INFO : => ${error.toString()}');

    // if error is related to http or server connection
    if (error is BasicServiceErrorException && errorCallback == null) {
      String? title;
      String? description;

      if (backEndMessage != null) {
        title = backEndMessage?.message ?? 'Internal Server Error';
        description = backEndMessage?.errors ??
            'Sorry, Our system is currently experiencing technical issues, please try again later';
      } else {
        title = 'Internal Server Error';
        description = 'Sorry, Our system is currently experiencing technical issues, please try again later';
      }

      // show message to user
      _bottomSheetService.showBottomSheet(title: title!, description: description);
    } else {
      if (errorCallback == null) {
        _bottomSheetService.showBottomSheet(
            title: 'Something When Wrong',
            description: 'Sorry, Something wrong with our system, please try again later.');
      } else {
        errorCallback.call();
      }
    }
  }
}
