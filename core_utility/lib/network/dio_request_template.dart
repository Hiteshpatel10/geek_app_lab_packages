import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'core_dio_client.dart';

enum RequestFrom { branchLocator }

Future<dynamic> getRequest({
  required String apiEndPoint,
  required RequestFrom requestFrom,
}) async {
  Dio client = CoreDioClient().init();

  Response? response;
  try {
    debugPrint(
        "^^^^^^^^^^^^^^^^^^ $apiEndPoint getRequest Start ${requestFrom.name} ^^^^^^^^^^^^^^^^^^");

    response = await client.get(apiEndPoint);

    debugPrint("^^^^^^^^^^^^^^^^^^ $apiEndPoint getRequest End ^^^^^^^^^^^^^^^^^^");

    if (response.statusCode != 200) {
      throw DioError(
        requestOptions: RequestOptions(path: apiEndPoint),
        response: response,
      );
    }

    if (response.data == null) {
      throw DioError(
        requestOptions: RequestOptions(path: apiEndPoint),
        response: response,
      );
    }
  } on DioError catch (dioError) {
    debugPrint("Error in getRequest: Failed to call api $apiEndPoint ${dioError.message}");
    rethrow;
  } catch (error) {
    debugPrint("Error in getRequest: $apiEndPoint $error");
    rethrow;
  }

  return response.data;
}

Future<dynamic> postRequest({
  required String apiEndPoint,
  required Map<String, dynamic> postData,
  required RequestFrom requestFrom,
}) async {
  Dio client = CoreDioClient().init();
  Response? response;

  try {
    debugPrint(
        "~~~~~~~~~~~~~~~~~~~~ $apiEndPoint postRequest Start $requestFrom\n$postData ~~~~~~~~~~~~~~~~~~~~ ");

    response = await client.post(apiEndPoint, data: postData);

    if (response.statusCode != 200) {
      throw DioError(
        requestOptions: RequestOptions(path: apiEndPoint),
      );
    }

    if (response.data == null) {
      throw DioError(
        requestOptions: RequestOptions(path: apiEndPoint),
        response: response,
      );
    }

    debugPrint("~~~~~~~~~~~~~~~~~~~~ $apiEndPoint postRequest End~~~~~~~~~~~~~~~~~~~~ ");
  } on DioError catch (dioError) {
    debugPrint("Error in getRequest: Failed to call api ${dioError.message}");
    rethrow;
  } catch (error) {
    debugPrint("Error in getRequest:");
    rethrow;
  }

  return response.data;
}
