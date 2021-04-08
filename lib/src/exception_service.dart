import 'dart:io';
import 'package:dio/dio.dart';
import 'package:basic_services/src/service_locator.dart';
import '../basic_services.dart';

mixin ExceptionServiceMixin {
  final _dialogService = dependenciesLocator<DialogService>();

  void onHandlingError(error, Object? key, {Function? errorCallback}) {
    print('Key event is : $key');
    print('Error event is : $error');

    // if error is Dio Error
    if (error is DioError && errorCallback == null) {
      if (error.type == DioErrorType.response) {
        print('RESPONSE');
        _dialogService!.showDialog(title: 'RESPONSE', description: error.toString());
      }
      if (error.type == DioErrorType.connectTimeout) {
        print('CONNECT_TIMEOUT');
        _dialogService!.showDialog(title: 'CONNECT_TIMEOUT', description: error.toString());
      }
      if (error.type == DioErrorType.other) {
        print('DEFAULT');
        _dialogService!.showDialog(title: 'DEFAULT', description: error.toString());
      }
      if (error.type == DioErrorType.cancel) {
        print('CANCEL');
        _dialogService!.showDialog(title: 'CANCEL', description: error.toString());
      }
      if (error.type == DioErrorType.sendTimeout) {
        print('SEND_TIMEOUT');
        _dialogService!.showDialog(title: 'SEND_TIMEOUT', description: error.toString());
      }
      if (error.type == DioErrorType.receiveTimeout) {
        print('RECEIVE_TIMEOUT');
        _dialogService!.showDialog(title: 'RECEIVE_TIMEOUT', description: error.toString());
      }
    } else {
      // handle other event error here
      if (error is SocketException) {
        _dialogService!.showDialog(title: 'SocketException', description: error.toString());
      }
      if (error is HttpException) {
        _dialogService!.showDialog(title: 'HttpException', description: error.toString());
      }

      if (errorCallback == null) {
        _dialogService!.showDialog(title: 'Error', description: error.toString());
      } else {
        errorCallback.call();
      }
    }
  }
}
