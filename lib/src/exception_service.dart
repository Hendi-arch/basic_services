import 'dart:io';
import 'package:dio/dio.dart';
import '../basic_services.dart';
import 'service_locator.dart';

mixin ExceptionServiceMixin {
  final _bottomSheetService = dependenciesLocator<BottomSheetService>();

  void onHandlingError(error, backEndMessage, Object? key, {Function? errorCallback}) {
    print('Key event is : $key');
    print('[Hendi Dev] ERROR INFO : => ${error.toString()}');

    // if error is related to http or server connection
    if (error is DioError || error is SocketException || error is HttpException && errorCallback == null) {
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
