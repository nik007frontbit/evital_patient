import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Api {
  final Dio _api = Dio();

  Api() {
    _api.options.baseUrl = "https://dev-api.evitalrx.in/v1/whitelabel/login";
    _api.interceptors.add(PrettyDioLogger());
  }

  Dio get sendRequest => _api;
}
