import 'package:dio/dio.dart';

void main() async {
  var _dioInstance = Dio()..interceptors.add(LogInterceptor());

  final response = await _dioInstance
      .post('http://35.213.157.102:3030/api/sign_in?login_name=MASTERROOT&password=81DC9BDB52D04DC20036DBD8313ED055');
  print(response.statusMessage);
  print(response.data);
}
