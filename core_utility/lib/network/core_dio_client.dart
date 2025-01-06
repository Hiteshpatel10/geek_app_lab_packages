import 'package:core_utility/core_utility.dart';
import 'package:dio/dio.dart';

class CoreDioClient {
  Dio init() {
    Dio dio = Dio();

    // final prefs = GetStorage();
    //
    // var token = prefs.read('TOKEN');
    // dio.options.headers["Authorization"] = token;
    // dio.options.headers["device"] = Platform.isAndroid ? 'Android' : 'IOS';
    // dio.options.headers["source"] = globalSource.name;
    dio.options.baseUrl = globalBaseUrl;

    return dio;
  }
}

class Utilis{

}
