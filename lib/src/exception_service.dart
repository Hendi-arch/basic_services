import 'dart:io';
import 'package:dio/dio.dart';
import 'package:xulu_services/src/service_locator.dart';
import '../xulu_services.dart';

mixin ExceptionServiceMixin {
  final _dialogService = dependenciesLocator<DialogService>();

  void onHandlingError(error, Object key, {Function errorCallback}) {
    print('Key event is : $key');
    print('Error event is : $error');

    // if error is Dio Error
    if (error is DioError && errorCallback == null) {
      if (error.type == DioErrorType.RESPONSE) {
        print('RESPONSE');
        _dialogService.showDialog(title: 'RESPONSE', description: error.toString());
      }
      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        print('CONNECT_TIMEOUT');
        _dialogService.showDialog(title: 'CONNECT_TIMEOUT', description: error.toString());
      }
      if (error.type == DioErrorType.DEFAULT) {
        print('DEFAULT');
        _dialogService.showDialog(title: 'DEFAULT', description: error.toString());
      }
      if (error.type == DioErrorType.CANCEL) {
        print('CANCEL');
        _dialogService.showDialog(title: 'CANCEL', description: error.toString());
      }
      if (error.type == DioErrorType.SEND_TIMEOUT) {
        print('SEND_TIMEOUT');
        _dialogService.showDialog(title: 'SEND_TIMEOUT', description: error.toString());
      }
      if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
        print('RECEIVE_TIMEOUT');
        _dialogService.showDialog(title: 'RECEIVE_TIMEOUT', description: error.toString());
      }
    }

    // handle other event error here
    if (error is SocketException) {
      _dialogService.showDialog(title: 'SocketException', description: error.toString());
    }
    if (error is HttpException) {
      _dialogService.showDialog(title: 'HttpException', description: error.toString());
    }

    if (errorCallback == null) {
      _dialogService.showDialog(title: 'Error', description: error.toString());
    } else {
      errorCallback.call();
    }
  }
}
