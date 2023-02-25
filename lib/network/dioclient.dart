import 'package:dio/dio.dart';
import 'package:weatherapp/utils/urls.dart';

class DioClient {
  final Dio _dio = Dio();

  Dio get dio => _dio;

  DioClient() {
    _dio.options.baseUrl = APIUrls.baseUrl;
  }
}
